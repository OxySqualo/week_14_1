import 'package:flutter/material.dart';
import 'package:week_14_1/services/local_notification_service.dart';
import 'package:week_14_1/screens/second_screen.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final LocalNotificationService service;

  @override
  void initState() {
    service = LocalNotificationService();
    service.intialize();
    listenToNotification();
    service.scheduleDailyEightAMNotification(
      id: 0,
      title: 'Уведомление в 8 утра каждый день',
      body: 'Новый день! Flutter ждет!',
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 160, 8, 8),
        title: const Text('Локальные уведомления'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: SizedBox(
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 100,
                    width: 200,
                    color: const Color.fromARGB(255, 160, 8, 8),
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            Color.fromARGB(255, 160, 8, 8)),
                      ),
                      onPressed: () async {
                        await service.scheduleDailyEightAMNotification(
                          id: 0,
                          title: 'Уведомление в 8 утра каждый день',
                          body: 'Новый день! Flutter ждет!',
                        );
                      },
                      child: const Text('Уведомление\n в 8 утра\n каждый день',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 200,
                    color: const Color.fromARGB(255, 160, 8, 8),
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            Color.fromARGB(255, 160, 8, 8)),
                      ),
                      onPressed: () async {
                        await service.showNotificationWithPayload(
                            id: 0,
                            title: 'Уведомление с загрузкой',
                            body:
                                'Нажми на уведомление, чтобы увидеть сообщение',
                            payload: 'Время для Flutter!');
                      },
                      child: const Text('Уведомление\n с загрузкой',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void listenToNotification() =>
      service.onNotificationClick.stream.listen(onNoticationListener);

  void onNoticationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => SecondScreen(payload: payload))));
    }
  }
}
