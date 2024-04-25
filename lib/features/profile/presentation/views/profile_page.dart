import 'dart:io';

import 'package:app_cinema/core/common/userPreferences/user_preferences.dart';
import 'package:app_cinema/features/auths/presentation/auth_route.dart';
import 'package:app_cinema/widgets/touch_dismiss_keyboard_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../apps/config/conf_colors.dart';
import '../../../../widgets/date_picker_widget.dart';
import '../../../../widgets/gender_item.dart';
import '../../../../widgets/infor_item.dart';
import '../../../../widgets/language_toggle_item.dart';
import '../../../auths/domain/entities/user_entity.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import 'screens/ticket_detail_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late UserEntity currentUser;
  bool isReceiveNotification = false;
  late String avatarUrl;
  bool isLoadingAvatar = false;
  DateTime _selectedDate = DateTime.now();
  Gender _selectedGender = Gender.Male;
  late String dropdownValue;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final ValueNotifier<bool> _isDataChanged = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    avatarUrl = 'assets/image/AppIcon.png';
    dropdownValue = listCity.first;
    BlocProvider.of<ProfileBloc>(context).add(LoadUserProfile());
    fullNameController.addListener(_checkForChanges);
    phoneNumberController.addListener(_checkForChanges);
    emailController.addListener(_checkForChanges);
    BlocProvider.of<ProfileBloc>(context).add(GetUserTickets());
  }

  void _checkForChanges() {
    bool hasChanged = fullNameController.text != currentUser.fullName ||
        phoneNumberController.text != currentUser.phoneNumber ||
        emailController.text != currentUser.email ||
        _selectedDate != currentUser.dob ||
        _selectedGender.toString().split('.').last.toLowerCase() !=
            currentUser.gender.toLowerCase() ||
        dropdownValue != currentUser.city ||
        avatarUrl != currentUser.avatarUrl;
    _isDataChanged.value = hasChanged;
  }

  @override
  void dispose() {
    fullNameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    profileBloc.stream.listen((state) {
      if (state is ProfileLoaded) {
        _updateTextControllers(state.user);
      }
    });
  }

  // late ThemeData _themeData;

  void _handleDateChanged(DateTime date) {
    setState(() {
      _selectedDate = date;
      _checkForChanges();
    });
  }

  void _handleGenderChanged(Gender gender) {
    setState(() {
      _selectedGender = gender;
      _checkForChanges();
    });
  }

  void _updateTextControllers(UserEntity user) {
    currentUser = user;
    if (mounted) {
      fullNameController.text = user.fullName;
      emailController.text = user.email;
      phoneNumberController.text = user.phoneNumber;

      _selectedDate = user.dob;
      _selectedGender = Gender.values.firstWhere(
          (g) =>
              g.toString().split('.').last.toLowerCase() ==
              user.gender.toLowerCase(),
          orElse: () => Gender.Other);

      dropdownValue = listCity.contains(user.city) ? user.city : listCity.first;
      avatarUrl = user.avatarUrl.isNotEmpty
          ? user.avatarUrl
          : 'assets/image/AppIcon.png';

      _checkForChanges();
    }
  }

  void saveProfile() {
    final userToUpdate = UserEntity(
      email: emailController.text,
      fullName: fullNameController.text,
      dob: _selectedDate,
      phoneNumber: phoneNumberController.text,
      gender: _selectedGender.toString().split('.').last,
      city: dropdownValue,
      avatarUrl: avatarUrl,
      uid: currentUser.uid,
    );

    BlocProvider.of<ProfileBloc>(context).add(UpdateUserProfile(userToUpdate));
  }

  final List<String> listCity = <String>[
    "Ho Chi Minh City",
    "Hanoi",
    "Da Nang",
    "Can Tho",
    "Hue",
    "Unknown"
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoaded) {
          _updateTextControllers(state.user);
        }
        if (state is ProfileImageUpdateInProgress) {
          setState(() {
            isLoadingAvatar = true;
          });
        } else if (state is ProfileImageUpdateSuccess ||
            state is ProfileImageUpdateFailure) {
          setState(() {
            isLoadingAvatar = false;
            if (state is ProfileImageUpdateSuccess) {
              avatarUrl =
                  state.imageUrl.isNotEmpty ? state.imageUrl : avatarUrl;
            }
          });
        }
        if (state is ProfileUpdateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile Updated Successfully')),
          );
          _isDataChanged.value = false;
          currentUser = state.updatedUser;
          BlocProvider.of<ProfileBloc>(context).add(GetUserTickets());
        }
        if (state is ProfileUpdateFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        if (state is ProfileLoading || state is ProfileUpdateInProgress) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ProfileError || state is ProfileUpdateFailure) {
          return Center(
            child: Text(
              state is ProfileError
                  ? 'An error occurred while loading the profile.'
                  : 'An error occurred while updating the profile.',
            ),
          );
        }

        return _buildProfileForm(context, state);
      },
    );
  }

  Widget _buildProfileForm(BuildContext context, ProfileState state) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;
    final ColorScheme colorScheme = themeData.colorScheme;

    return TouchOutsideToDismissKeyboard(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ConfigColors().appBarColor,
          leading: IconButton(
            padding: const EdgeInsets.only(left: 15),
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: themeData.colorScheme.primaryContainer,
            ),
          ),
          title: Center(
            child: Text(
              'Profile',
              style: textTheme.titleLarge,
            ),
          ),
          actions: [
            IconButton(
              onPressed: _showLogoutDialog,
              icon: Icon(
                Icons.logout,
                color: themeData.colorScheme.primaryContainer,
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: ValueListenableBuilder<bool>(
          valueListenable: _isDataChanged,
          builder: (context, value, child) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 30,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final picker = ImagePicker();
                        final pickedFile =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (pickedFile != null) {
                          final imageFile = File(pickedFile.path);
                          final profileBloc =
                              BlocProvider.of<ProfileBloc>(context);
                          setState(() {
                            avatarUrl = imageFile.path;
                          });
                          profileBloc.add(
                            UpdateUserProfileImage(
                              currentUser.copyWith(avatarUrl: avatarUrl),
                              imageFile,
                            ),
                          );
                        }
                      },
                      child: Stack(
                        children: [
                          CircleAvatar(
                            key: ValueKey(avatarUrl),
                            radius: 45,
                            backgroundImage: avatarUrl.contains('http')
                                ? NetworkImage(avatarUrl)
                                : FileImage(File(avatarUrl)) as ImageProvider,
                            onBackgroundImageError: (_, __) => const AssetImage(
                                'assets/image/default_avatar.png'),
                          ),
                          if (isLoadingAvatar)
                            Positioned.fill(
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.black45,
                                  shape: BoxShape.circle,
                                ),
                                child: const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      fullNameController.text,
                      style: textTheme.titleLarge,
                    ),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Information",
                        style: textTheme.titleMedium?.copyWith(
                          color: colorScheme.primaryContainer,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Column(
                      children: [
                        InfoRow(
                          title: "Fullname",
                          controller: fullNameController,
                          titleStyle: textTheme.bodyMedium,
                        ),
                        InfoRow(
                          isDeco: false,
                          title: "Date of birth",
                          titleStyle: textTheme.bodyMedium,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: DatePickerWidget(
                              onDateChanged: _handleDateChanged,
                              initialDate: _selectedDate,
                            ),
                          ),
                        ),
                        InfoRow(
                          title: "Phone number",
                          titleStyle: textTheme.bodyMedium,
                          isPhone: true,
                          controller: phoneNumberController,
                        ),
                        InfoRow(
                          title: "Email",
                          controller: emailController,
                          titleStyle: textTheme.bodyMedium,
                        ),
                        InfoRow(
                          isDeco: false,
                          title: "Gender",
                          titleStyle: textTheme.bodyMedium,
                          child: GenderItem(
                            onGenderChanged: _handleGenderChanged,
                            initialGender: _selectedGender,
                          ),
                        ),
                        InfoRow(
                          isDeco: false,
                          title: "City",
                          titleStyle: textTheme.bodyMedium,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              height: 40,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.white.withOpacity(0.2),
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: dropdownValue,
                                  icon: const Icon(Icons.arrow_drop_down,
                                      color: Colors.white),
                                  style: const TextStyle(color: Colors.white),
                                  dropdownColor: ConfigColors().primaryColor,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownValue = newValue!;
                                      _checkForChanges();
                                    });
                                  },
                                  items: listCity.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (value)
                          GestureDetector(
                            onTap: saveProfile,
                            child: Container(
                              width: 100,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              child: Center(
                                child: Text(
                                  "SAVE",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Settings",
                            style: textTheme.titleMedium?.copyWith(
                              color: colorScheme.primaryContainer,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            InfoRow(
                              title: "Language",
                              titleStyle: textTheme.bodyMedium,
                              isDeco: false,
                              child: const LanguageToggle(),
                            ),
                            InfoRow(
                              title: "Receive notification",
                              titleStyle: textTheme.bodyMedium,
                              isDeco: false,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Switch(
                                  value: isReceiveNotification,
                                  activeColor: Colors.orange,
                                  onChanged: (bool value) {
                                    setState(() {
                                      isReceiveNotification = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),
                        ticketHistorySection(state),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget ticketHistorySection(ProfileState state) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;
    final ColorScheme colorScheme = themeData.colorScheme;

    if (state is UserTicketsLoaded && state.tickets.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payments history',
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.primaryContainer,
            ),
          ),
          const SizedBox(height: 10),
          ...state.tickets.map((ticket) {
            if (ticket != null) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TicketDetailScreenInProfile(
                          ticket: ticket.convertToEntity()),
                    ),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Poster
                          ticket.posterUrl != null
                              ? Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Image.network(
                                    ticket.posterUrl!,
                                    width: 60,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Image.network(
                                  "https://motivatevalmorgan.com/wp-content/uploads/2016/06/default-movie.jpg",
                                  width: 60,
                                  fit: BoxFit.cover,
                                ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ticket.title ?? 'Phim Không Xác Định',
                                    style: textTheme.titleMedium,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    DateFormat('dd MMMM yyyy, HH:mm').format(
                                        ticket.sessionDateTime ??
                                            DateTime.now()),
                                    style: textTheme.bodySmall,
                                  ),
                                  Text(
                                    ticket.theaterName ?? 'Rạp không xác định',
                                    style: textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      );
    } else if (state is UserTicketsLoaded && state.tickets.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Text(
          'No payment history.',
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onBackground.withOpacity(0.6),
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                UserPreferences.clearToken();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    AuthRoute.loginRouteName, (Route<dynamic> route) => false);
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
