import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:housepital/src/constants/colors.dart';
import 'package:housepital/src/constants/styles.dart';
import 'package:housepital/src/screen/home/webViewPage.dart';
import 'package:housepital/src/screen/home/home_detail.dart';

class LayoutPage extends StatefulWidget {
  List layout ;
  LayoutPage(this.layout);
  @override
  _LayoutPageState createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  var layoutcode=0;
  Widget layoutContainer(width,imagename,title,imagefit){
    
    return Container(
     // color: greyBackgroundColor,
      width: MediaQuery.of(context).size.width/width,
      child: Column(
        children: <Widget>[
          Container(
            height: 120.0,
            child: ClipRRect(
              child: Image.network(imagename,fit: imagefit== 'fill' ? BoxFit.fill : BoxFit.fitWidth,width: MediaQuery.of(context).size.width/width
              ,),
            ),
          ),
          SizedBox(height:6.0),
          SizedBox(height:20.0,child: Center(child: Text(title ,style: Styles.blackTextwithf12,))),
          SizedBox(height:6.0),
        ],
      ),
    );
  }
//40.0




  _firstlayout(data){

    if(data['layout_code']=="1"){
      if(data['title']==""){
        return new Container(
          child: new SizedBox(
            height: 2.0,
          ),
        );
      } else{
      return Container(
          margin: EdgeInsets.only(left: 6.0, top: 6.0,bottom: 0.0),
          child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(data['title']!=null ?data['title']:"", style: Styles.primaryTextwithf16,)
            ],
          ),
          ),
      );
      }
    }
    else if(data['layout_code']=="40"){
      return Container(
        padding: EdgeInsets.all(1.0),
        margin: EdgeInsets.only(top:1.0,left: 8.0,right:8.0,bottom: 1.0),
        child: new Divider(
          height:2.0,
          color: Colors.black,
        ),
      );
    }
    else if(data['layout_code']=="43"){
      return Container(
        padding: EdgeInsets.all(4.0),
        child: GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, data['next_page']['page_code'],arguments: {'data_heading': data['next_page']['data_heading'],'data_self': data['next_page']['data_self'],'data_url': data['next_page']['data_url']});
          },
          child: layoutContainer(2,data['image'],data['title'],'contain')),
      );
    }

    else if(data['layout_code']=="42"){
    
    
      layoutcode ++;
   
       return Align(
         alignment: layoutcode%2==0 ? Alignment.topRight : Alignment.topLeft,
         child: Container(
             
              width: MediaQuery.of(context).size.width/2.2,
               padding: EdgeInsets.all(4.0),
               margin: EdgeInsets.only(top:0.0,left: 8.0,right:8.0,bottom: 0.0),
               child: GestureDetector(
               onTap: (){

               
                 Navigator.pushNamed(context, data['next_page']['page_code']
                 ,arguments: {'data_heading': data['next_page']['data_heading']
                 ,'data_self': data['next_page']['data_self'],'data_url': data['next_page']['data_url']});
              
               },
                         // child: Row(
                         //   children: <Widget>[
               child:  layoutContainer(2,data['image'],data['title'],'contain'),
                       //     ], 
                       // ),
                      ),
                                  ),
       );
    
     
       
    }



    else if(data['layout_code']=="2"){
      if(data['image']==""){
        return new Container(
          child: new SizedBox(
            height: 15.0,
          ),
        );

      }
      
      
      
      else{
      
      return InkWell(
        onTap: (){
          if(data['web_view']== "0"){
            Navigator.pushNamed(context, data['next_page']['page_code'],arguments: data['next_page']);
          }else{
            Navigator.push(context, MaterialPageRoute(
            builder: (context) => WebViewPage(
              path: data['web_link'],
              title: data['web_view_heading'], ),
            ));
          }
          
        },
        child: Container(
        padding: EdgeInsets.all(6.0),
        margin: EdgeInsets.symmetric(vertical: 6.0,horizontal: 12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1.0,color: Colors.grey[400]),
          boxShadow: [
              BoxShadow(
                color: Colors.grey[400],
                blurRadius: 5.0,
                offset: Offset(0, 5),
              ),
            ],
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child: Column(
            children: <Widget>[
              new Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                child: new ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  child: new Image(
                      image: NetworkImage(data['image']),
                      fit: BoxFit.cover,
                      loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                        return Center(
                          child: LinearProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null ? 
                                loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        );
                      },
                    ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width - 60,
                  height: 30.0,
                  child: AutoSizeText(data['text'] !=null ?data['text']:"", 
                    style: TextStyle(color: Colors.black54,fontSize: 16.0),
                    maxLines: 2,minFontSize: 12.0,softWrap: true, overflow: TextOverflow.clip,)),
              )
            ],
          ),
        ),
      );
      }
    }
    else if(data['layout_code']=="3"){
      return InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
            builder: (context) => WebViewPage(
              path: data['web_link'],
              title: data['web_view_heading'], ),
            ));
          },
          child: Container(
          padding: EdgeInsets.all(6.0),
          margin: EdgeInsets.symmetric(vertical: 6.0,horizontal: 12.0),
          height: 90.0,
          decoration: BoxDecoration(
            color: Colors.white ,
            border: Border.all(width: 1.0,color: Colors.grey[400]),
            boxShadow: [
                    BoxShadow(
                      color: Colors.grey[400],
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                  ],
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: Row(
              children: <Widget>[
                new Container(
                  height: 90.0,
                  width:110.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(data['image']))
                    ),
                  
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(data['text']!=null ?data['text']:"", style: TextStyle(color: Colors.black54,fontSize: 16.0),textAlign: TextAlign.justify,),
                ),
              )
              
            ],
          )
        ),
      );
    }
    else if(data['layout_code']=="4"){
      return Container(
        margin: EdgeInsets.all(12.0),
        height: 400.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          boxShadow: [
              BoxShadow(
                color: Colors.grey[400],
                blurRadius: 5.0,
                offset: Offset(0, 5),
              ),
            ],
        ),
        child: new Column(
          children: <Widget>[
            new Expanded(
              child: new ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
              child: new Image(
                width: MediaQuery.of(context).size.width,
                image: NetworkImage(data['image']),
                fit: BoxFit.fill,
              ),
            ),
            ),
            
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
              
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: new Text(data['text']!=null ?data['text']:"", style: TextStyle(color: Colors.black54,fontSize: 22.0,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: new Icon(Icons.arrow_forward , color: Colors.black54,size: 30.0,),
                )
              ],
            )
          ],
        )
      );
    }
    else if(data['layout_code']=="5"){
      return Container(
        padding: EdgeInsets.all(6.0),
        margin: EdgeInsets.all(8.0),
        height:110.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          image: DecorationImage(
            image: NetworkImage(data['image']),
            fit: BoxFit.cover
          ),
        ),
      );
    }
    else if(data['layout_code']=="6"){
      return Container(
        padding: EdgeInsets.all(6.0),
        margin: EdgeInsets.all(8.0),
        child: new Column(
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 2.0,bottom: 20.0),
                  child: new Text(data['title']!=null ?data['title']:"", style: TextStyle(color: Colors.black54,fontSize: 20.0,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 2.0,bottom: 20.0),
                  child: new Text(data['text']!=null ?data['text']:"", style: TextStyle(color: Colors.black54,fontSize: 20.0,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _listhrdata(data['elements'][0]),
                _listhrdata(data['elements'][1]),
                _listhrdata(data['elements'][2]),
              ],
            )
          ],
        )
      );
    }
    else{
      return Container(
        padding: EdgeInsets.all(6.0),
        margin: EdgeInsets.only(top:8.0,left: 8.0,right:8.0,bottom: 16.0),
        child: new Divider(
          height:2.0,
          color: Colors.black,
        ),
      );
    }
    //return Text(data['layout_code'], style: TextStyle(color: Colors.deepPurple));
  }






  

   _listhrdata(datael){
     String colorbg = datael['element_bg_color'].replaceAll('#', '0xff');
     String colorfont = datael['element_text_color'].replaceAll('#', '0xff');
    return new Container(
      height: 200.0,
      width:MediaQuery.of(context).size.width/3.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        color: new Color(int.parse(colorbg)),
      ),
      child: Center(child: new Text(datael['element_name']!=null? datael['element_name']:"",style: TextStyle(color: new Color(int.parse(colorfont)),fontSize: 18.0),)),
    );
      //return myList;
  }






  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: widget.layout == null ?0 : widget.layout.length ,
      itemBuilder: (BuildContext context, i){
        return _firstlayout(widget.layout[i]);
      },
    ) ;
  }




}