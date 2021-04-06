import 'package:flutter/material.dart';
import 'package:scaffold_z/items.dart';
import 'package:scaffold_z/appbar_z.dart';
import 'package:scaffold_z/scaffold_z.dart';

class Colorization {
  final Color backgroundColor, childColor;
  Colorization({required this.backgroundColor, required this.childColor});
}

class ZDrawerWidget extends StatefulWidget {
  List<DrawerItem> items;
  Widget? title;
  Color bgColor;
  final BuildContext context;
  final bool isMob;
  Colorization? unselectedItemColor, selectedItemColor;
  ZDrawerWidget({required this.items, this.isMob = false, this.title,required this.bgColor,required this.context,Colorization? unselectedItemColor,Colorization? selectedItemColor}){
    init(selectedItemColor, unselectedItemColor);
  }
  init(c1, c2){
    if(c1 == null){
      this.selectedItemColor = Colorization(
        backgroundColor: Colors.grey.shade300,
        childColor: Colors.blue
      );
    }else{
      this.selectedItemColor = c1;
    }
    if(c2 == null){
      this.unselectedItemColor = Colorization(
        backgroundColor: Colors.transparent,
        childColor: Colors.black54
      );
    }else{
      this.unselectedItemColor = c2;
    }
  }
  @override
  _ZDrawerWidgetState createState() => _ZDrawerWidgetState();
}

class _ZDrawerWidgetState extends State<ZDrawerWidget> {
  late List<DrawerItem> items = widget.items;
  late Widget? title = widget.title;
  late Color bgColor = widget.bgColor;
  late BuildContext _buildContext = widget.context;
  late bool isMob = widget.isMob;
  int? chosenIndex;
  int? chosenSubIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: this.bgColor,
      child: Column(
        children: [
          if(isMob && this.title != null)...{
            Container(
              width: double.infinity,
              height: 60,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: (){
                      Navigator.of(context).pop(null);
                    },
                  ),
                  if(this.title != null)...{
                    const SizedBox(
                      width: 10,
                    ),
                    this.title!,
                  }
                ],
              ),
            )
          },
          Expanded(
            child: ListView(
              children: [
                for(var item in  this.items)...{
                  Container(
                    width: double.infinity,
                    height: 60,
                    color: chosenIndex == this.items.indexOf(item) ? widget.selectedItemColor!.backgroundColor : widget.unselectedItemColor!.backgroundColor,
                    child: MaterialButton(
                      onPressed: (){

                        if(item.content != null){
                          if(isMob){
//                            Navigator.of(context).pop(null);
                          }
                          ScaffoldZ().chooseContentFromDrawer(context, content: item.content!);
                          setState(() {
                            chosenIndex = this.items.indexOf(item);
                          });
                        }else {
                          setState(() {
                            if(chosenIndex == this.items.indexOf(item)){
                              chosenIndex = null;
                            }else{
                              chosenIndex = this.items.indexOf(item);
                            }
                          });
                        }
                      },
                      child: Row(
                        children: [
                          if(item.icon != null)...{
                            Icon(item.icon, color: chosenIndex == this.items.indexOf(item) ? widget.selectedItemColor!.childColor : widget.unselectedItemColor!.childColor,),
                            const SizedBox(
                              width: 10,
                            )
                          },
                          Expanded(
                            child: Text(item.title,style: TextStyle(
                              color: chosenIndex == this.items.indexOf(item) ? widget.selectedItemColor!.childColor : widget.unselectedItemColor!.childColor
                            ),),
                          ),
                          if(item.sub_content != null)...{
                            Icon(chosenIndex == this.items.indexOf(item) ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right, color: chosenIndex == this.items.indexOf(item) ? widget.selectedItemColor!.childColor : widget.unselectedItemColor!.childColor,)
                          }
                        ],
                      ),
                    ),
                  ),
                  if(item.sub_content != null)...{
                    for(var sub_item in item.sub_content!)...{
                      AnimatedContainer(
                        width: double.infinity,
                        height: chosenIndex == this.items.indexOf(item) ? 60 : 0,
                        decoration: BoxDecoration(
                          color: chosenSubIndex == item.sub_content!.indexOf(sub_item) ? widget.selectedItemColor!.backgroundColor : widget.unselectedItemColor!.backgroundColor,
                        ),
                        duration: Duration(milliseconds: (item.sub_content!.indexOf(sub_item) + 1) * 100),
                        child: MaterialButton(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          onPressed: (){
                            if(sub_item.content != null){
                              if(isMob){
//                                Navigator.of(context).pop(null);
                              }
                              ScaffoldZ().chooseContentFromDrawer(context, content: sub_item.content!);
                              setState(() {
                                chosenSubIndex = item.sub_content!.indexOf(sub_item);
                              });
                            }
                          },
                          child: Row(
                            children: [
                              if(sub_item.icon != null && chosenIndex == this.items.indexOf(item))...{
                                Icon(sub_item.icon, color: chosenSubIndex == item.sub_content!.indexOf(sub_item) ? widget.selectedItemColor!.childColor : widget.unselectedItemColor!.childColor,),
                                const SizedBox(
                                  width: 10,
                                )
                              },
                              Expanded(
                                child: Text(sub_item.title,style: TextStyle(
                                  color: chosenSubIndex == item.sub_content!.indexOf(sub_item) ? widget.selectedItemColor!.childColor : widget.unselectedItemColor!.childColor
                                ),),
                              )
                            ],
                          ),
                        ),
                      ),
                    }
                  }

                }
              ],
            ),
          )
        ],
      ),
    );
  }
}