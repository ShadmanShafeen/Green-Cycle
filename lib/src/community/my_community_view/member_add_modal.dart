import 'package:flutter/material.dart';
import 'package:green_cycle/src/community/my_community_view/new_mem_req.dart';

class MemberAddModal extends StatefulWidget {
  const MemberAddModal({super.key});

  @override
  State<MemberAddModal> createState() => _MemberAddModalState();
}

class _MemberAddModalState extends State<MemberAddModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          image: DecorationImage(
              image: AssetImage(
                'lib/assets/img/member_modal_bg.jpg',
              ),
              fit: BoxFit.cover,
              opacity: .8)),
      child: Column(
        children: [
          const SizedBox(
            height: 60,
            child: Center(
              child: Text(
                'Member Request',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: newmem.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: Theme.of(context)
                      .colorScheme
                      .primaryFixedDim
                      .withOpacity(0.7),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ExpansionTile(
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    title: Text(
                      newmem[index].name,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 30,
                              width: 150,
                              child: FilledButton(
                                onPressed: () {},
                                style: const ButtonStyle(
                                  backgroundColor:
                                      WidgetStatePropertyAll<Color>(
                                    Color.fromARGB(50, 136, 68, 240),
                                  ),
                                  fixedSize: WidgetStatePropertyAll<Size>(
                                    Size.fromWidth(200),
                                  ),
                                ),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondaryFixedDim,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Accept',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 40),
                            SizedBox(
                              height: 30,
                              width: 150,
                              child: FilledButton(
                                onPressed: () {},
                                style: const ButtonStyle(
                                  backgroundColor:
                                      WidgetStatePropertyAll<Color>(
                                    Color.fromARGB(50, 136, 68, 240),
                                  ),
                                  fixedSize: WidgetStatePropertyAll<Size>(
                                    Size.fromWidth(200),
                                  ),
                                ),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.delete,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiaryFixedDim,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Reject',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
