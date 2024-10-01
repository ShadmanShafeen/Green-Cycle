import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:green_cycle/src/authentication/login.dart';

class WasteItemsWheel extends StatelessWidget {
  WasteItemsWheel({super.key, required this.scrollController});

  final ScrollController scrollController;
  final ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      openCloseDial: isDialOpen,
      label: Text(
        'Learn',
        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      ),
      icon: Icons.recycling,
      activeIcon: Icons.recycling,
      curve: Curves.easeInOut,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Theme.of(context).colorScheme.primaryFixed,
      direction: SpeedDialDirection.up,
      switchLabelPosition: true,
      spacing: 10,
      childrenButtonSize: const Size(55, 55),
      onPress: () {
        scrollController.animateTo(
          scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        isDialOpen.value = true;
      },
      children: [
        SpeedDialChild(
          shape: const CircleBorder(),
          backgroundColor: Colors.transparent,
          labelWidget: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            color: Theme.of(context).colorScheme.primaryFixed.withOpacity(0.8),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              child: Text(
                'Glass',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
          child: Image.asset('lib/assets/images/recycle_items/glass.png'),
          onTap: () {
            context.go("/home/search-waste" , extra: "GLASS");
          },
        ),
        SpeedDialChild(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          backgroundColor: Colors.transparent,
          labelWidget: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            color: Theme.of(context).colorScheme.primaryFixed.withOpacity(0.8),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              child: Text(
                'Paper',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
          child: Image.asset('lib/assets/images/recycle_items/paper.png'),
          onTap: () {
            context.go("/home/search-waste" , extra: "PAPER");
          },
        ),
        SpeedDialChild(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          backgroundColor: Colors.transparent,
          labelWidget: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              color:
                  Theme.of(context).colorScheme.primaryFixed.withOpacity(0.8),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 5, bottom: 5, left: 10, right: 10),
                child: Text(
                  'Metal',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              )),
          child: Image.asset('lib/assets/images/recycle_items/metal.png'),
          onTap: () {
            context.go("/home/search-waste" , extra: "METAL");
          },
        ),
        SpeedDialChild(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          backgroundColor: Colors.transparent,
          labelWidget: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            color: Theme.of(context).colorScheme.primaryFixed.withOpacity(0.8),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              child: Text(
                'Plastic',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
          child: Image.asset('lib/assets/images/recycle_items/plastic.png'),
          onTap: () {
            context.go("/home/search-waste" , extra: "PLASTIC");
          },
        ),
        SpeedDialChild(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          backgroundColor: Colors.transparent,
          labelWidget: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            color: Theme.of(context).colorScheme.primaryFixed.withOpacity(0.8),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              child: Text(
                'Cardboard',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
          child: Image.asset('lib/assets/images/recycle_items/cardboard.png'),
          onTap: () {
            context.go("/home/search-waste" , extra: "CARDBOARD");
          },
        ),
      ],
    );
  }
}
