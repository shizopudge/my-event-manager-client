import 'package:client/bloc/auth/auth_bloc.dart';
import 'package:client/bloc/event/event_bloc.dart';
import 'package:client/bloc/events/events_bloc.dart';
import 'package:client/core/style.dart';
import 'package:client/cubit/add_event/color_picker_cubit.dart';
import 'package:client/cubit/add_event/priority_wheel_cubit.dart';
import 'package:client/cubit/add_event/stepper_cubit.dart';
import 'package:client/cubit/add_event/stepper_error_cubit.dart';
import 'package:client/cubit/add_event/type_cubit.dart';
import 'package:client/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../core/constants.dart';
import '../widgets/color_picker.dart';
import '../widgets/create_event_text_field.dart';
import '../widgets/date_picker.dart';
import '../widgets/type_widget.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final FixedExtentScrollController _priorityController =
      FixedExtentScrollController();
  late TextEditingController _dateController;
  late TextEditingController _timeController;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _priorityController.dispose();
    _titleController.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<AddEventPriorityWheelCubit>().setPriority('Low');
    context.read<AddEventStepperCubit>().setStep(0);
    context.read<AddEventStepperErrorCubit>().reset();
    _dateController = TextEditingController(
      text: defaultDateFormat.format(
        DateTime.now(),
      ),
    );
    _timeController = TextEditingController(
      text: defaultTimeFormat.format(
        DateTime.now(),
      ),
    );
  }

  DateTime dateNow = DateTime.now();
  TimeOfDay timeNow = TimeOfDay.now();
  DateTime? pickedDate;
  TimeOfDay? pickedTime;

  @override
  Widget build(BuildContext context) {
    final bool isError = context.watch<AddEventStepperErrorCubit>().state;
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final int currentStep = context.watch<AddEventStepperCubit>().state;
    final bool isLoading = context.select<EventBloc, bool>(
      (bloc) => bloc.state.isLoading,
    );
    final String color = context.watch<AddEventColorPickerCubit>().state;
    final String uid =
        context.select<AuthBloc, String>((bloc) => bloc.state.user?.id ?? '');
    final String currentPriority =
        context.watch<AddEventPriorityWheelCubit>().state;
    final String type = context.watch<AddEventTypeCubit>().state;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add event',
          style: AppTheme.hintStyle,
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<EventBloc, EventState>(
        listenWhen: (previous, current) =>
            current.event != null &&
            !current.isLoading &&
            (current.event?.id ?? '').isNotEmpty,
        listener: (context, state) {
          context.read<EventsBloc>().add(
                EventsGetUserEventsEvent(
                  uid: uid,
                ),
              );
          context.goNamed(
            'event',
            queryParams: {
              'id': state.event?.id ?? '',
            },
          );
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stepper(
                    physics: const ClampingScrollPhysics(),
                    currentStep: currentStep,
                    onStepTapped: (step) =>
                        context.read<AddEventStepperCubit>().setStep(step),
                    controlsBuilder: (context, details) {
                      if (currentStep < 5) {
                        return SubmitButton(
                          content: Text(
                            'Continue',
                            style: AppTheme.mainStyle,
                          ),
                          onTap: () {
                            if (currentStep == 0) {
                              if (_titleController.text.isNotEmpty) {
                                context
                                    .read<AddEventStepperCubit>()
                                    .increment();
                                context
                                    .read<AddEventStepperErrorCubit>()
                                    .reset();
                              } else {
                                context
                                    .read<AddEventStepperErrorCubit>()
                                    .error();
                              }
                            } else {
                              context.read<AddEventStepperCubit>().increment();
                            }
                          },
                          height: height * .06,
                          width: width,
                        );
                      } else {
                        return SubmitButton(
                          content: isLoading
                              ? const CircularProgressIndicator(
                                  strokeWidth: 2,
                                )
                              : Text(
                                  'Finish',
                                  style: AppTheme.mainStyle,
                                ),
                          onTap: isLoading
                              ? () {}
                              : () {
                                  context.read<EventBloc>().add(
                                        EventCreateEventEvent(
                                          eventDate: DateTime(
                                            pickedDate?.year ?? dateNow.year,
                                            pickedDate?.month ?? dateNow.month,
                                            pickedDate?.day ?? dateNow.day,
                                            pickedTime?.hour ?? timeNow.hour,
                                            pickedDate?.minute ??
                                                timeNow.minute,
                                          ),
                                          type: type,
                                          context: context,
                                          title: _titleController.text.trim(),
                                          description: _descriptionController
                                              .text
                                              .trim(),
                                          color: color.toString(),
                                          priority: currentPriority,
                                          authorId: uid,
                                        ),
                                      );
                                  context.read<EventsBloc>().add(
                                        EventsGetUserEventsEvent(uid: uid),
                                      );
                                },
                          height: height * .06,
                          width: width,
                        );
                      }
                    },
                    steps: [
                      Step(
                        state: isError
                            ? StepState.error
                            : currentStep == 0
                                ? StepState.editing
                                : currentStep > 0
                                    ? StepState.complete
                                    : StepState.disabled,
                        isActive: currentStep > 0,
                        title: Text(
                          'Title',
                          style: AppTheme.mainStyle,
                        ),
                        content: CreateEventTextfield(
                          controller: _titleController,
                          hint: 'Title (required)',
                          isError: isError,
                        ),
                      ),
                      Step(
                        state: currentStep == 1
                            ? StepState.editing
                            : currentStep > 1
                                ? StepState.complete
                                : StepState.disabled,
                        isActive: currentStep > 1,
                        title: Text(
                          'Description',
                          style: AppTheme.mainStyle,
                        ),
                        content: CreateEventTextfield(
                          controller: _descriptionController,
                          isDescription: true,
                          hint: 'Description (optional)',
                        ),
                      ),
                      Step(
                        state: currentStep == 2
                            ? StepState.editing
                            : currentStep > 2
                                ? StepState.complete
                                : StepState.disabled,
                        isActive: currentStep > 2,
                        title: Text(
                          'Color',
                          style: AppTheme.mainStyle,
                        ),
                        content: const ColorPicker(),
                      ),
                      Step(
                        state: currentStep == 3
                            ? StepState.editing
                            : currentStep > 3
                                ? StepState.complete
                                : StepState.disabled,
                        isActive: currentStep > 3,
                        title: Text(
                          'Priority',
                          style: AppTheme.mainStyle,
                        ),
                        content: SizedBox(
                          height: 125,
                          child: SizedBox(
                            width: 300,
                            child: ListWheelScrollView.useDelegate(
                              controller: _priorityController,
                              itemExtent: 55,
                              perspective: 0.005,
                              diameterRatio: 1.5,
                              onSelectedItemChanged: (index) => context
                                  .read<AddEventPriorityWheelCubit>()
                                  .setPriority(
                                    priorityList[index],
                                  ),
                              physics: const FixedExtentScrollPhysics(),
                              childDelegate: ListWheelChildBuilderDelegate(
                                childCount: 4,
                                builder: (context, index) {
                                  final String priority = priorityList[index];
                                  if (currentPriority == priority) {
                                    return Text(
                                      priority,
                                      style: AppTheme.mainStyle.copyWith(
                                        color: Colors.blueGrey.shade500,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.white,
                                        decorationThickness: 1,
                                      ),
                                    );
                                  } else {
                                    return Text(
                                      priority,
                                      style: AppTheme.mainStyle,
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Step(
                        state: currentStep == 4
                            ? StepState.editing
                            : currentStep > 4
                                ? StepState.complete
                                : StepState.disabled,
                        isActive: currentStep > 4,
                        title: Text(
                          'Type',
                          style: AppTheme.mainStyle,
                        ),
                        content: GridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 3,
                          shrinkWrap: true,
                          children: [
                            TypeWidget(
                              image: 'assets/icons/Party.png',
                              title: 'Party',
                              currentType: type,
                              onTap: () => context
                                  .read<AddEventTypeCubit>()
                                  .setType('Party'),
                            ),
                            TypeWidget(
                              image: 'assets/icons/Job.png',
                              title: 'Job',
                              currentType: type,
                              onTap: () => context
                                  .read<AddEventTypeCubit>()
                                  .setType('Job'),
                            ),
                            TypeWidget(
                              image: 'assets/icons/Conference.png',
                              title: 'Conference',
                              currentType: type,
                              onTap: () => context
                                  .read<AddEventTypeCubit>()
                                  .setType('Conference'),
                            ),
                            TypeWidget(
                              image: 'assets/icons/Sport.png',
                              title: 'Sport',
                              currentType: type,
                              onTap: () => context
                                  .read<AddEventTypeCubit>()
                                  .setType('Sport'),
                            ),
                            TypeWidget(
                              image: 'assets/icons/Chill.png',
                              title: 'Chill',
                              currentType: type,
                              onTap: () => context
                                  .read<AddEventTypeCubit>()
                                  .setType('Chill'),
                            ),
                            TypeWidget(
                              image: 'assets/icons/Study.png',
                              title: 'Study',
                              currentType: type,
                              onTap: () => context
                                  .read<AddEventTypeCubit>()
                                  .setType('Study'),
                            ),
                            TypeWidget(
                              image: 'assets/icons/Other.png',
                              title: 'Other',
                              currentType: type,
                              onTap: () => context
                                  .read<AddEventTypeCubit>()
                                  .setType('Other'),
                            ),
                          ],
                        ),
                      ),
                      Step(
                        state: currentStep == 5
                            ? StepState.editing
                            : currentStep > 5
                                ? StepState.complete
                                : StepState.disabled,
                        isActive: currentStep > 5,
                        title: Text(
                          'Date and time',
                          style: AppTheme.mainStyle,
                        ),
                        content: Column(
                          children: [
                            TextFieldDateTimePicker(
                              hint: 'Date',
                              controller: _dateController,
                              isDate: true,
                              onTap: () async {
                                pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: dateNow,
                                  firstDate: dateNow,
                                  lastDate: DateTime(dateNow.year + 1),
                                );
                                if (pickedDate != null) {
                                  _dateController.text = defaultDateFormat
                                      .format(pickedDate ?? DateTime.now());
                                }
                              },
                            ),
                            TextFieldDateTimePicker(
                              hint: 'Time',
                              controller: _timeController,
                              isDate: false,
                              onTap: () async {
                                pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: timeNow,
                                );
                                if (pickedTime != null) {
                                  _timeController.text = pickedTime
                                      .toString()
                                      .split('(')[1]
                                      .split(')')[0];
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
