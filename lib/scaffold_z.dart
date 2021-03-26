library scaffold_z;
import 'package:scaffold_z/packed/main_exporter.dart';

class ScaffoldZ extends StatefulWidget {
  ZAppbar? appbar;
  final Color? bgColor;
  final Widget? body;
  ScaffoldZ({this.appbar, this.bgColor = Colors.white, this.body});

  chooseContentFromDrawer(BuildContext context, {required Widget content}) {
    context.findAncestorStateOfType<_ScaffoldZState>()!.changeSelectedContent(content);
  }
  @override
  _ScaffoldZState createState() => _ScaffoldZState();
}

class _ScaffoldZState extends State<ScaffoldZ> {
  bool _showItems = true;
  bool _enableSearchIcon = false;
  Widget? _selectedContent;

  TextEditingController _searchField = new TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void changeSelectedContent(Widget n){
    setState(() {
      _selectedContent = n;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
  }
  initialize() async {
    setState(() {
      _showItems = widget.appbar!.drawer != null && widget.appbar!.drawer!.items! != null  && widget.appbar!.drawer!.items!.length > 0;
      if(widget.appbar!.drawer != null && widget.appbar!.drawer!.items! != null){
        _selectedContent = widget.appbar!.drawer!.items![0].content;
      }
    });
//    await
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if(Platform.isMacOS || Platform.isLinux || Platform.isWindows){
      DesktopWindow.setMinWindowSize(Size(500,700));
    }
    return Scaffold(
        key: _scaffoldKey,
        drawer: widget.appbar!.drawer != null && widget.appbar!.drawer!.items! != null  && size.width < 900 ? Drawer(
            child: SafeArea(
              child: ZDrawerWidget(
                context: context,
                title: widget.appbar!.title,
                items: widget.appbar!.drawer!.items!,
                isMob: size.width < 900,
                bgColor: widget.appbar!.drawer!.drawerColor ?? Colors.grey.shade100,
              ),
            )
        ) : null,
        backgroundColor: widget.bgColor,
        body: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Container(
                  height: size.height - 60,
                  width: double.infinity,
                  color: widget.bgColor,
                  child: Row(
                    children: [
                      if(size.width > 900 && widget.appbar!.drawer != null && widget.appbar!.drawer!.items! != null)...{
                        AnimatedContainer(
                          width: _showItems ? 300 : 0,
                          height: size.height,
                          color: Colors.white,
                          duration: Duration(milliseconds: 100),
                          child: ZDrawerWidget(
                            context: context,
                            items: widget.appbar!.drawer!.items!,
                            isMob: size.width < 900,
                            bgColor: widget.appbar!.drawer!.drawerColor ?? Colors.grey.shade100,
                          ),
                        ),
                      },
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(size.width > 900 ? 5 : 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 2,
                                  offset: Offset(-2,1),

                                )
                              ]
                          ),
                          child: widget.body ?? _selectedContent ?? Container(
                            width: double.infinity,
                            child: Center(
                              child: Text("No Content Detected, please add a body or a content in drawer items"),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              if(widget.appbar != null)...{
                Container(
                  padding: widget.appbar!.leading == null && (widget.appbar!.drawer == null || widget.appbar!.drawer!.items! == null) ? widget.appbar!.padding : const EdgeInsets.only(left: 0, right: 10),
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: widget.appbar!.bgColor ?? Colors.grey.shade100,
                    boxShadow: [
                      BoxShadow(
                          color: widget.appbar!.elevation > 0 ? Colors.grey.shade400 : Colors.transparent,
                          offset: Offset(0,widget.appbar!.elevation),
                          blurRadius: 2,
                          spreadRadius: 0.5
                      )
                    ],
                  ),
                  child: Row(
                    children: [

                      if(widget.appbar!.drawer != null && widget.appbar!.drawer!.items! != null && widget.appbar!.drawer!.items!.length > 0)...{
                        IconButton(
                          onPressed: (){
                            if(size.width > 900){
                              setState(() {
                                _showItems = !_showItems;
                              });
                            }else{
                              if(_scaffoldKey.currentState!.isDrawerOpen){
                                Navigator.of(context).pop(null);
                              }else{
                                _scaffoldKey.currentState!.openDrawer();
                              }
                            }
                          },
                          icon: Icon(Icons.menu),
                        )
                      },
                      widget.appbar!.leading ?? Container(),
                      if(widget.appbar!.drawer != null && widget.appbar!.drawer!.items != null || widget.appbar!.leading != null)...{
                        const SizedBox(
                          width: 10,
                        )
                      },
                      widget.appbar!.title,
                      Spacer(),
                      if(widget.appbar!.search != null && widget.appbar!.search!.enable)...{
                        AnimatedContainer(
                          width: size.width > 900 || _enableSearchIcon ? size.width/3 : 50,
                          height: 50,
                          duration: Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade400,
                                    offset: Offset(-2,2),
                                    blurRadius: 2
                                )
                              ],
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: size.width > 900 || _enableSearchIcon ? TextField(
                            onSubmitted: (text){
                              widget.appbar!.search!.searchCallback!(text);
                            },
                            controller: _searchField,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                                alignLabelWithHint: true,
                                hintText: 'Search',
                                prefixIcon: Icon(Icons.search,color: Colors.black54,),
                                contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                  onPressed: (){
                                    setState(() {
                                      _enableSearchIcon = false;
                                      _searchField.clear();
                                    });
                                  },
                                  icon: Icon(Icons.clear),
                                )
                            ),
                          ) : MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)
                            ),
                            padding: const EdgeInsets.all(0),
                            onPressed: (){
                              if(Platform.isIOS || Platform.isAndroid){
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (_) => MobileSearchPage(
                                          lookAt: widget.appbar!.search!.lookAt,
                                          searchData: widget.appbar!.search!,
                                        )
                                    )
                                );
                              }else{
                                setState(() {
                                  _enableSearchIcon = !_enableSearchIcon;
                                });
                              }
                            },
                            child: Center(
                              child: Icon(Icons.search,color: Colors.black54,),
                            ),
                          ),
                        )
                      },
                      if(widget.appbar!.actions != null)...{
                        for(var action in widget.appbar!.actions!)...{
                          const SizedBox(
                            width: 5,
                          ),
                          action
                        }
                      }
                    ],
                  ),
                )
              }
            ],
          ),
        )
    );
  }
}

