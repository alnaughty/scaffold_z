import 'package:flutter/material.dart';
import 'package:scaffold_z/items.dart';
import 'package:scaffold_z/appbar_z.dart';
import 'package:scaffold_z/scaffold_z.dart';

class ZDrawerWidget extends StatefulWidget {
  List<DrawerItem> items;
  Widget? title;
  Color bgColor;
  final BuildContext context;
  final bool isMob;
  ZDrawerWidget({required this.items, this.isMob = false, this.title,required this.bgColor,required this.context});
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
                    child: MaterialButton(
                      onPressed: (){
                        if(item.content != null){
                          if(isMob){
                            Navigator.of(context).pop(null);
                          }
                          ScaffoldZ().chooseContentFromDrawer(context, content: item.content!);
                        }else{
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
                            Icon(item.icon),
                            const SizedBox(
                              width: 10,
                            )
                          },
                          Expanded(
                            child: item.title,
                          ),
                          if(item.sub_content != null)...{
                            Icon(chosenIndex == this.items.indexOf(item) ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right)
                          }
                        ],
                      ),
                    ),
                  ),
                    if(item.sub_content != null)...{
                      for(var sub_item in item.sub_content!)...{
                        AnimatedContainer(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: double.infinity,
                          height: chosenIndex == this.items.indexOf(item) ? 60 : 0,
                          duration: Duration(milliseconds: (item.sub_content!.indexOf(sub_item) + 1) * 100),
                          child: MaterialButton(
                            onPressed: (){
                              if(sub_item.content != null){
                                if(isMob){
                                  Navigator.of(context).pop(null);
                                }
                                ScaffoldZ().chooseContentFromDrawer(context, content: sub_item.content!);
                              }
                            },
                            child: Row(
                              children: [
                                if(sub_item.icon != null && chosenIndex == this.items.indexOf(item))...{
                                  Icon(sub_item.icon),
                                  const SizedBox(
                                    width: 10,
                                  )
                                },
                                Expanded(
                                  child: sub_item.title,
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