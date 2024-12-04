import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'cubit/cubit.dart';
import 'cubit/state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhoneNumberCubit(),
      child: BlocBuilder<PhoneNumberCubit, PhoneNumberState>(
          builder: (context, state) {
        var cubit = context.read<PhoneNumberCubit>();
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IntlPhoneField(
              controller: cubit.phoneEditingController,
              showCountryFlag: false,
              keyboardType: TextInputType.number,
              showDropdownIcon: false,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(10),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                labelText: "phone",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  borderSide: BorderSide(),
                ),
              ),
              onCountryChanged: (v) {
                cubit.countryCode = '+${v.fullCountryCode}';
                print("Country changed to: ${v.name}");
              },
              initialCountryCode: 'AE', // Saudi Arabia country code
              onChanged: (phone) {
                print(phone.completeNumber);
              },
            ),
          ),
        );
      }),
    );
  }
}
