import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_trackerr/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:habit_trackerr/features/auth/presentation/screens/login_screen.dart';

import '../../../auth/presentation/cubit/auth_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;
    String? name;
    String? email;
    String? phone;
    String? dateOfBirth;

    // Extract user data
    if (authState is LoginSuccess) {
      name = authState.authModel.data?.name;
      email = authState.authModel.data?.email;
      phone = authState.authModel.data?.phone;
    } else if (authState is RegisterSuccess) {
      name = authState.authModel.name;
      email = authState.authModel.email;
      phone = authState.authModel.phone;
      dateOfBirth = authState.authModel.dateOfBirth;
    }

    Future<void> _logout() async {
      context.read<AuthCubit>().emit(AuthInitial());
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
            (Route<dynamic> route) => false,
      );
    }

    Future<void> _clearData() async {
      try {
        await context.read<AuthCubit>().clearData();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data cleared successfully')),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
              (Route<dynamic> route) => false,
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error clearing data: ${e.toString()}')),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // User Details Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('User Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    _buildDetailRow('Name', name),
                    const Divider(),
                    _buildDetailRow('Email', email),
                    const Divider(),
                    _buildDetailRow('Phone', phone),
                    if (dateOfBirth != null) ...[
                      const Divider(),
                      _buildDetailRow('Date of Birth', dateOfBirth),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Clear Data Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _clearData,
                child: const Text('Clear Data'),
              ),
            ),
            const SizedBox(height: 16),
            // Logout Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: _logout,
                child: const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value ?? 'Not available', style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}