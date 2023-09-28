import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vcare_app/core/widgets/CustomCircularProgressIndicator.dart';
import 'package:vcare_app/feature/history_screen/business_logic/get_appointments_cubit/get_appointments_cubit.dart';
import '../widget/appointment_card.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    BlocProvider.of<GetAppointmentsCubit>(context).getAllAppointment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: BlocBuilder<GetAppointmentsCubit, GetAppointmentsState>(
        builder: (context, state) {
          if (state is GetAppointmentsSuccess) {
            return ListView.separated(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: state.appointments.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) =>
                  AppointmentCard(appointmentModel: state.appointments[index]),
            );
          } else if (state is GetAppointmentsError) {
            return Center(
              child: Text(state.errorMessage),
            );
          }
          return const CustomCircularProgressIndicator();
        },
      ),
    );
  }
}
