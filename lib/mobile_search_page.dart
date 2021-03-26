import 'package:scaffold_z/packed/search_exporter.dart';

class MobileSearchPage extends StatefulWidget {
  final List? lookAt;
  final ZSearch searchData;
  MobileSearchPage({this.lookAt, required this.searchData});
  @override
  _MobileSearchPageState createState() => _MobileSearchPageState();
}

class _MobileSearchPageState extends State<MobileSearchPage> {
  TextEditingController _search = new TextEditingController();
  late List _displayData = List.from(widget.lookAt as List);
  _searchCallback(String text) {
    widget.searchData.searchCallback!(text);
//    List searcher = List.from(widget.lookAt as List);
    setState(() {
      if(widget.searchData.type.isObject){
        _displayData = List.from(widget.lookAt as List).where((element) => element['${widget.searchData.type.keyToCheck ?? ""}'].toString().toLowerCase().contains(text.toLowerCase())).toList();
      }else{
        _displayData = List.from(widget.lookAt as List).where((element) => element.toString().toLowerCase().contains(text.toLowerCase())).toList();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Material(
          child: SafeArea(
            child: Column(
              children: [
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 5,top: 10,bottom: 10,right: 5),
                    child: Row(
                      children: [
                        IconButton(icon: Icon(Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios), onPressed: (){
                          Navigator.of(context).pop();
                        }),
                        Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(4)
                              ),
                              child: TextField(
                                controller: _search,
                                onSubmitted: _searchCallback,
                                decoration: InputDecoration(
                                  hintText: "Search",
                                    border: InputBorder.none,
                                    suffixIconConstraints: BoxConstraints(
                                        maxHeight: 20,
                                        maxWidth: 20
                                    ),
                                    suffixIcon: IconButton(
                                      padding: const EdgeInsets.all(0),
                                      onPressed: (){
                                        setState(() {
                                          _displayData = List.from(widget.lookAt as List);
                                          _search.clear();
                                        });
                                      },
                                      icon: Icon(Icons.cancel,size: 20,color: Colors.grey[400],),
                                    )
                                ),
                              ),
                            )
                        ),
                        IconButton(icon: Icon(Icons.search), onPressed: (){
                          _searchCallback(_search.text);
                        })
                      ],
                    )
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (_, x)=> Divider(),
                    itemCount: _displayData.length,
                    itemBuilder: (_, x) {
                      return MaterialButton(
                        padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                        onPressed: (){},
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: !widget.searchData.type.isObject ? Text("${_displayData[x]}") : Text("${_displayData[x]['${ widget.searchData.type.keyToCheck ?? ""}']}"),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
