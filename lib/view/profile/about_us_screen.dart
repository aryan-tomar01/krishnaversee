import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class AboutUsScreen extends StatefulWidget{
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {

  Widget SectionTitle (String title){
    return Padding(
      padding: const EdgeInsets.only(top:22,bottom: 8),
      child: Text(
        title,style: const TextStyle(
        color: Color(0xffD4AF37),
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      ),
    );
  }

  Widget SectionText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 15,
        height: 1.6,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff142B56),
      appBar: AppBar(
        backgroundColor: const Color(0xff142B56),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(onPressed: ()=> Get.back(),
          icon: Icon(Icons.arrow_back_ios,
            color: Color(0xffD4AF37),
          ),
        ),
        title: Text('About Us',
          style: TextStyle(
            color: Color(0xffD4AF37),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
              color: const Color(0xff1B3767),
              borderRadius: BorderRadius.circular(18)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Icon(Icons.auto_stories,
                  size: 60,
                  color: Color(0xffD4AF37),
                ),
              ),

              SizedBox(height: 15,),

              Center(
                child: Text('KrishnaVerse',
                  style: TextStyle(
                    color: Color(0xffD4AF37),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              SectionTitle("Welcome to KrishnaVerse"),

              SectionText("KrishnaVerse is a spiritual learning platform dedicated to bringing the timeless wisdom of the Bhagavad Gita to everyone. Our mission is to make reading, listening, and understanding the teachings of Lord Krishna simple, accessible, and inspiring for people of all ages."),

              SectionTitle("Our Mission"),

              SectionText("Our mission is to help people build a daily spiritual habit through meaningful reading, audio recitations, and practical teachings from the Bhagavad Gita that can be applied in everyday life."),

              SectionTitle("What We Offer"),

              SectionText("• Complete Bhagavad Gita Chapters\n• Sanskrit Shlokas with Meaning\n• Audio Playback\n• Daily Reading Streak\n• Continue Reading Progress\n• Calm Mind Meditation\n• Inspirational Krishna Quotes"),

              SectionTitle("Our Vision"),

              SectionText("We believe that the wisdom of the Bhagavad Gita has the power to bring peace, clarity, and purpose to modern life. KrishnaVerse aims to make these teachings available to everyone through a simple and beautiful digital experience."),

              SectionTitle("❤️ Thank You"),

              SectionText(
                'Thank you for being a part of the KrishnaVerse family.\n\n'
                    '"Whenever there is a decline in righteousness and an increase in unrighteousness, I manifest Myself."\n\n'
                    '— Bhagavad Gita 4.7',
              ),

              const SizedBox(height: 30),

              const Divider(
                color: Colors.white12,
              ),

              const SizedBox(height: 15),

              Center(
                  child: Column(
                    children: [
                      Text("Version 1.0",
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 13,
                        ),
                      ),

                      SizedBox(height: 6),

                      Text("Made with ❤️ for Bhagavad Gita learners",
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 13,
                        ),
                      )
                    ],
                  )
              )



            ],
          ),
        ),
      ),

    );
  }
}