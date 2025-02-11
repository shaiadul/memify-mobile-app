import 'package:flutter/material.dart';
import 'package:memify/controller/fetchMeme.dart';
import 'package:memify/controller/saveMyData.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
   String imgUrl = "";
   int? memeNo;
   int targetMeme = 100;
   bool isLoading = true;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetInitMemeNo();
    updateImg();
  }
    GetInitMemeNo() async{
    memeNo = await SaveMyData.fetchData() ?? 0;
    if(memeNo! > 100 ){
      targetMeme = 500;
    }else if(memeNo! > 500){
      targetMeme  = 9999;
    }
    setState(() {

    });
  }
  void updateImg() async {
    String getImgUrl = await FetchMeme.fetchNewMeme();
    setState(() {
      imgUrl = getImgUrl;
      isLoading = false;
    });
  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Text(
              "Meme Generator #${memeNo.toString()}",
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                fontSize: 25.0, 
                color: Colors.orangeAccent),
              ),
            Text(
              "Targeted Meme ${targetMeme.toString()}",
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                fontSize: 20.0, 
                color: const Color.fromARGB(255, 66, 63, 63),
              )
              ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              
              child: 
              isLoading ? 
              Image.network( "https://media.giphy.com/media/3oEjI6SIIHBdRxXI40/giphy.gif",)
               :
              Image.network(
                imgUrl,
                // width: 300.0,
                // height: 300.0,
                // fit: BoxFit.cover,
                ),
            ),
            SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                await SaveMyData.saveData(memeNo!+1);
                GetInitMemeNo();
                updateImg();
              }, 
              child: Text(
              "Generate Meme", 
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                fontSize: 20.0, 
                color: const Color.fromARGB(255, 66, 63, 63)),
              ), 
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)
                )
                ),
              ),
            Spacer(),
            Text(
              "Created by",
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                fontSize: 20.0, 
                color: Colors.orangeAccent),
              ),
            Padding(
              padding: const EdgeInsets.only(bottom: 05.0),
              child: Text(
                "Md Saidul Bashar",
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 15.0, 
                  color: const Color.fromARGB(255, 66, 63, 63)),
                ),
            ),
          ],
        ),
      ),
    );
  }
}