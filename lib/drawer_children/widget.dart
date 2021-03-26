import 'package:flutter/material.dart';
import 'package:scaffold_z/items.dart';
import 'package:scaffold_z/appbar_z.dart';
import 'package:scaffold_z/scaffold_z.dart';
class ZDrawerWidget extends StatelessWidget {
  List<DrawerItem> items;
  Widget? title;
  Color bgColor;
  final BuildContext context;
  final bool isMob;
  ZDrawerWidget({required this.items, this.isMob = false, this.title,required this.bgColor,required this.context});
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
                        if(isMob){
                          Navigator.of(context).pop(null);
                        }
                        ScaffoldZ().chooseContentFromDrawer(context, content: item.content);
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
                          )
                        ],
                      ),
                    ),
                  )
                }
              ],
            ),
          )
        ],
      ),
    );
  }
}
