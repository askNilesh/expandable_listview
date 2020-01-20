import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomeWidget(),
  ));
}

class ModelData {
  String categoryName;
  String subTitle;
  bool isSelected;
  List childItems = List<ChildModelData>();

  ModelData(this.categoryName, this.subTitle, this.isSelected, this.childItems);
}

class ChildModelData {
  String itemName;
  Color itemColor;

  ChildModelData(this.itemName, this.itemColor);
}

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return buildWidget(context);
  }

  final colorList = [
    Colors.blue[600],
    Colors.blue[500],
    Colors.blue[400],
    Colors.blue[300],
    Colors.blue[200]
  ];
  List listItems = List<ModelData>();
  int _activeMeterIndex = -1;

  Widget buildWidget(BuildContext context) {
    for (var i = 0; i < 10; i++) {
      List childItems = List<ChildModelData>();
      for (var j = 0; j < 5; j++) {
        ChildModelData model = ChildModelData("Child Item $j", colorList[j]);
        childItems.add(model);
      }
      ModelData data =
          ModelData("Category Item $i", "subTitle", false, childItems);
      listItems.add(data);
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text(
            'Home',
          ),
        ),
        body: ListView.builder(
            itemCount: listItems.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              ModelData modelData = listItems[index];
              return Card(
                margin: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0.0),
                child: ExpansionPanelList(
                  animationDuration: Duration(seconds: 1),
                  expansionCallback: (int childIndex, bool status) {
                    setState(() {
                      _activeMeterIndex =
                          _activeMeterIndex == index ? -1 : index;
                    });
                  },
                  children: [
                    ExpansionPanel(
                      isExpanded: _activeMeterIndex == index,
                      headerBuilder: (BuildContext context, bool isExpanded) =>
                          GestureDetector(
                        onTap: () {
                          setState(() {
                            _activeMeterIndex =
                                _activeMeterIndex == index ? -1 : index;
                          });
                        },
                        child: Container(
                            padding: const EdgeInsets.only(left: 15.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              modelData.categoryName,
                            )),
                      ),
                      body: Container(
                        child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: modelData.childItems.length,
                            shrinkWrap: true,
                            itemBuilder:
                                (BuildContext context, int childIndex) {
                              ChildModelData childData =
                                  modelData.childItems[childIndex];
                              return Column(
                                children: <Widget>[
                                  Container(
                                    height: 50,
                                    color: childData.itemColor,
                                    child:
                                        Center(child: Text(childData.itemName)),
                                  ),
                                ],
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              );
            }));
  }
}
