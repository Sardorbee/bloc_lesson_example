import 'package:bloc_lesson_example/data/bloc/cubits/api_example_cubit/api_example_cubit.dart';
import 'package:bloc_lesson_example/data/bloc/cubits/button_Color_cubit/button_color_cubit.dart';
import 'package:bloc_lesson_example/data/bloc/cubits/button_Color_cubit/button_color_state.dart';
import 'package:bloc_lesson_example/data/bloc/cubits/number_multiplier_cubit/nuber_multiplayer_cubit.dart';
import 'package:bloc_lesson_example/data/bloc/cubits/number_multiplier_cubit/nuber_multiplayer_state.dart';
import 'package:bloc_lesson_example/data/network/random_user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NumberScreen extends StatefulWidget {
  const NumberScreen({super.key});

  @override
  State<NumberScreen> createState() => _NumberScreenState();
}

class _NumberScreenState extends State<NumberScreen> {
  @override
  Widget build(BuildContext context) {
    final NuberMultiplayerCubit cubit = context.watch<NuberMultiplayerCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Numbers Multiplier Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                RangeTextInputFormatter(min: 0, max: 1000),
              ],
              controller: cubit.aController,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: "Enter First Number "),
              onChanged: (value) => cubit.calculateResult(),
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: cubit.bController,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                RangeTextInputFormatter(min: 0, max: 100),
              ],
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: "Enter Second Number"),
              onChanged: (value) => cubit.calculateResult(),
            ),
            const SizedBox(
              height: 5,
            ),
            BlocBuilder<NuberMultiplayerCubit, NumberState>(
              builder: (context, state) {
                String formattedResult = state is ResultState
                    ? cubit.formatResult(state.result)
                    : '0';

                return Text(
                  "Result: ${state is InitialState ? 0 : formattedResult}",
                  style: const TextStyle(fontSize: 25),
                );
              },
            ),
            SizedBox(
              height: 50,
              child: BlocBuilder<ButtonColorCubit, ButtonColorState>(
                builder: (context, state) {
                  return ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                      state.buttonColors.length,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<ButtonColorCubit>().update(index);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: state.buttonColors[index],
                            ),
                            child: Container(
                              width: 40,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  BlocBuilder<ApiExampleCubit, ApiExampleState>(
                    builder: (context, state) {
                      if (state is ApiExampleInitial) {
                        return Text('No data yet.');
                      } else if (state is ApiExampleLoaded) {
                        RandomModel randomModel = state.usersData;
                        Result result = randomModel.results.first;
                        return Center(
                          child: Column(
                            children: [
                              Center(
                                child: CircleAvatar(
                                  maxRadius: 70,
                                  backgroundImage: NetworkImage(result.picture.large),
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.person),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      "${result.name.title} ${result.name.first} ${result.name.last}")
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.location_on_outlined),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("city: ${result.location.city}"),
                                      Text("country:  ${result.location.country}"),
                                      Text("postcode: ${result.location.postcode}"),
                                      Text("state: ${result.location.state}"),
                                      Text(
                                          "street name:${result.location.street.name}"),
                                      Text(
                                          "street number:${result.location.street.number}"),
                                      Text(
                                          "Timezone: ${result.location.timezone.description}"),
                                      Text(
                                          "offsett:${result.location.timezone.offset}"),
                                      Text(
                                          "lat:${result.location.coordinates.latitude}"),
                                      Text(
                                          "lon:${result.location.coordinates.longitude}"),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.email),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(result.email)
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.person),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      "username: ${result.login.username} |  password:${result.login.password}")
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.phone),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(result.phone)
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.person_2),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text("Age: ${result.dob.age.toString()}")
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                      return SizedBox();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RangeTextInputFormatter extends TextInputFormatter {
  final int min;
  final int max;

  RangeTextInputFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final int parsedValue = int.tryParse(newValue.text) ?? 0;
    final int clampedValue = parsedValue.clamp(min, max);

    final newText = clampedValue.toString();
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
