import 'package:clay_containers/widgets/clay_container.dart';
import 'package:currency_exchange/api/api_response.dart';
import 'package:currency_exchange/provider/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Mainprovider? _mainPR;

  get children => null;

  @override
  void initState() {
    super.initState();
    _mainPR = Provider.of<Mainprovider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.5,
        elevation: 0.5,
        backgroundColor: const Color.fromARGB(255, 233, 230, 230),
        title: const Text(
          "Valyuta kurslari ",
          style: TextStyle(color: Colors.black),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(
              Icons.search_outlined,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: _mainPR?.getCurrencyRate(),
        builder: (BuildContext context, AsyncSnapshot<ApiResponse> snapshot) {
          if (snapshot.data?.status == Status.LOADING) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data?.status == Status.COMPLATED) {
            return ListView.builder(
                itemCount: snapshot.data?.data?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 20),
                    child: ClayContainer(
                      width: 200,
                      height: 120,
                      customBorderRadius:
                          const BorderRadius.all(Radius.circular(15)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, left: 25),
                                child: SizedBox(
                                  height: 20,
                                  width: 45,
                                  child: Image.asset(
                                    "assets/images/${snapshot.data?.data[index].code}.png",
                                    height: 20,
                                    width: 30,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20.0, right: 30),
                                child: Row(
                                  children: [
                                    Text(
                                      snapshot.data?.data[index].code ??
                                          ".........",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 205,
                                    ),
                                    Icon(
                                      Icons.notifications_active_outlined,
                                      size: 25,
                                      color: Colors.black.withOpacity(0.3),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Text("MB Kursi"),
                              Text(' Sotib Olish'),
                              Text(' Sotish '),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(snapshot.data?.data[index].cb_price ?? "",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                snapshot.data?.data[index].buy_price ?? "",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(snapshot.data?.data[index].cell_price ?? '',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          }
          if (snapshot.data?.status == Status.ERROR) {
            return errorMsg(snapshot.data?.message);
          }

          return Column(
            children: [
              Lottie.asset("assets/817-no-internet-connection.json"),
              Text(
                snapshot.data?.message ?? "Initial",
                style: const TextStyle(fontSize: 30),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget errorMsg(String? errorMess) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _mainPR?.getCurrencyRate();
        });
      },
      child: ListView(
        children: [
          const Center(
              child: Text("No internet ", style: TextStyle(fontSize: 30))),
          Lottie.asset("assets/817-no-internet-connection.json")
        ],
      ),
    );
  }
}
