import 'package:client/bloc/auth/auth_bloc.dart';
import 'package:client/bloc/event/event_bloc.dart';
import 'package:client/bloc/events/events_bloc.dart';
import 'package:client/core/style.dart';
import 'package:client/cubit/add_event/priority_wheel_cubit.dart';
import 'package:client/cubit/add_event/stepper_cubit.dart';
import 'package:client/cubit/add_event/stepper_error_cubit.dart';
import 'package:client/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:go_router/go_router.dart';

import '../core/constants.dart';
import '../widgets/create_event_text_field.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final FixedExtentScrollController _priorityController =
      FixedExtentScrollController();
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
  }

  String color = '0xfff7f7f7';

  @override
  Widget build(BuildContext context) {
    final bool isError = context.watch<AddEventStepperErrorCubit>().state;
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final int currentStep = context.watch<AddEventStepperCubit>().state;
    final bool isLoading = context.select<EventBloc, bool>(
      (bloc) => bloc.state.isLoading,
    );
    final String uid =
        context.select<AuthBloc, String>((bloc) => bloc.state.user?.id ?? '');
    final String currentPriority =
        context.watch<AddEventPriorityWheelCubit>().state;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add event',
          style: AppTheme.mainStyle,
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<EventBloc, EventState>(
        listenWhen: (previous, current) =>
            current.event != null &&
            !current.isLoading &&
            (current.event?.id ?? '').isNotEmpty,
        listener: (context, state) {
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
                      if (currentStep < 3) {
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
                        isActive: currentStep > 1,
                        title: Text(
                          'Color',
                          style: AppTheme.mainStyle,
                        ),
                        content: ColorPicker(
                          pickerColor: Colors.grey,
                          pickerAreaBorderRadius: BorderRadius.circular(21),
                          onColorChanged: (pickedColor) {
                            final String colorStr = pickedColor.toString();
                            color = colorStr.split('(')[1].split(')')[0];
                          },
                          labelTypes: const [],
                        ),
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
