import 'package:flutter/material.dart';
import 'package:toolbar/providers/providers.dart';

class UserBar extends StatelessWidget {
  const UserBar({ super.key });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      width: double.infinity,
      child: Material(
        color: ThemeProvider().primary,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: ThemeProvider().primary.shade700,
                foregroundColor: Colors.white, // TODO
                child: const Icon(Icons.person),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('User',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text('Description',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      )
    );
  }
}