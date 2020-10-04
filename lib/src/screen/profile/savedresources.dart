import 'package:housepital/src/constants/colors.dart';
import 'package:housepital/src/constants/styles.dart';
import 'package:flutter/material.dart';

class SavedResource extends StatefulWidget {
  @override
  _SavedResourceState createState() => _SavedResourceState();
}

class _SavedResourceState extends State<SavedResource> {
  
  @override
  Widget build(BuildContext context) {
    return SavedResource();
  }
  SavedResource(){
    return SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Container(
          height: 100.0 + 190.0 * 6,
          color: greyBackgroundColor,
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                width: MediaQuery.of(context).size.width,
                height: 60.0,
                decoration: BoxDecoration(
                  color: white100,
                  borderRadius: BorderRadius.circular(30.0)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Search',style: Styles.blackTextwithf18,),
                    Icon(Icons.search,color: secondaryColor,size: 28.0,)
                  ],
                ),
              ),
              SizedBox(height:32.0),
              Expanded(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 6,
                  itemBuilder: (context, int){
                    return Container(
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.only(bottom: 16.0),
                      decoration: BoxDecoration(
                        color: white100,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width/4,
                            height: 145.0,
                            decoration: BoxDecoration(
                              color: secondaryColor,
                              borderRadius: BorderRadius.circular(8.0)
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width/2,
                            padding: const EdgeInsets.only(top: 24.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Coping with stress',style: Styles.secondaryTextwithf18w6,),
                                SizedBox(height: 8.0,),
                                Text('20 minute read',style: Styles.blackopacity5f16,),
                                SizedBox(height: 12.0,),
                                Text('Lorem ipsum dolor sit amet, consetetur...',style: Styles.greyTextwithf18,softWrap: true,maxLines: 2,overflow: TextOverflow.ellipsis,)
                              ],
                            ),
                          ),
                          Icon(Icons.delete,color: secondaryColor, size: 24.0,)

                        ],
                      ),
                    );
                  }),
              ),
            ],
          ),
        ),
      );
  }

}