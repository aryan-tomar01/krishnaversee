import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/chapter.dart';
import '../../screens/chapter/chapter_detail_screen.dart';
import '../../services/supabase_service.dart';
import 'chapter_card.dart';

class AudioScreen extends StatefulWidget{
  const AudioScreen({super.key});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {

  final List<Map<String , dynamic>> famousShloks = [
    {
      "image": "assets/images/shlok1.jpeg",
      "title": "Dharmakshetre Kurukshetre",
      "chapter": "Chapter 1 • Verse 1",
      "chapterNumber": 1,
      "verseNumber": 1,
    },
    {
      "image": "assets/images/shlok2.jpeg",
      "title": "Drishtva Tu Pandavanikam",
      "chapter": "Chapter 1 • Verse 2",
      "chapterNumber": 1,
      "verseNumber": 2,
    },
    {
      "image": "assets/images/shlok3.jpeg",
      "title": "Sidanti Mama Gatrani",
      "chapter": "Chapter 1 • Verse 29",
      "chapterNumber": 1,
      "verseNumber": 29,
    },
    {
      "image": "assets/images/shlok4.png",
      "title": "Gandivam Sramsate Hastat",
      "chapter": "Chapter 1 • Verse 30",
      "chapterNumber": 1,
      "verseNumber": 30,
    },
    {
      "image": "assets/images/shlok5.jpeg",
      "title": "Na Kankshe Vijayam Krishna",
      "chapter": "Chapter 1 • Verse 32",
      "chapterNumber": 1,
      "verseNumber": 32,
    },
    {
      "image": "assets/images/shlok2.jpeg",
      "title": "Kula-Kshaye Pranashyanti",
      "chapter": "Chapter 1 • Verse 40",
      "chapterNumber": 1,
      "verseNumber": 40,
    },
    {
      "image": "assets/images/shlok1.jpeg",
      "title": "Yadi Mam Apratikaram",
      "chapter": "Chapter 1 • Verse 46",
      "chapterNumber": 1,
      "verseNumber": 46,
    },
  ];

  final AudioPlayer player = AudioPlayer();

  int? playingIndex;
  bool isPlaying = false;

  Future<void> playFamousShlok(int index) async {
    final shlok = famousShloks[index];

    try{
      if (playingIndex== index && isPlaying){
        await player.pause();

        setState(() {
          isPlaying = false;
        });
        return;
      }

      await player.stop();

      final audioUrl = SupabaseService.getVerseAudioUrl(
          chapterNumber : shlok["chapterNumber"],
          verseNumber : shlok["verseNumber"]
      );
      print("Playing Famous Shlok : $audioUrl");

      await player.play(
          UrlSource(audioUrl)
      );

      setState(() {
        playingIndex = index;
        isPlaying = true;
      });
    } catch (e) {
      print("Famous Shlok Audio Error : $e");
    }
  }

  PageController pageController = PageController(
    viewportFraction: 0.94,
  );

  int currentPage = 0;

  double progress = 0.45;

  @override
  void dispose(){
    pageController.dispose();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff142B56),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("Famous Shlokas",
                    style: TextStyle(
                      color: Color(0xffD4AF37),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 220,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: famousShloks.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:const EdgeInsets.only(right: 12,),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Stack(
                          children: [
                            Image.asset(famousShloks[index]["image"]! ,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors:[
                                        Colors.transparent,
                                        Colors.black54,
                                        Colors.black87,
                                      ],
                                      stops: const [0.3, 0.7, 1],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter)
                              ),
                            ),
                            Positioned(
                                left: 15,
                                bottom: 18,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      famousShloks[index]["title"]!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    SizedBox(height: 5),

                                    Text(famousShloks[index]["chapter"]!,
                                      style: TextStyle(
                                          color: Colors.white70
                                      ),
                                    ),
                                  ],
                                )
                            ),
                            Positioned(
                                right: 15,
                                bottom: 15,
                                child:
                                CircleAvatar(
                                    radius: 22,
                                    backgroundColor: const Color(0xffF6C344),
                                    child: IconButton(
                                      onPressed: (){
                                        playFamousShlok(index);
                                      },
                                      icon: Icon(
                                        playingIndex==index && isPlaying
                                            ? Icons.pause_rounded
                                            : Icons.play_arrow_rounded,
                                        size: 30,
                                        color: Colors.black,
                                      ),
                                    )
                                )
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  famousShloks.length,
                      (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: currentPage == index ? 22 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: currentPage == index
                          ? Colors.amber
                          : Colors.white24,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.all(12),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("Resume-Journey" ,
                    style: TextStyle(
                      color: Color(0xffD4AF37),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsetsGeometry.symmetric(horizontal: 12),
                padding: const EdgeInsets.all(12),
                height: 110,
                decoration: BoxDecoration(
                  color: const Color(0xff1D3D73),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color:  const Color(0xffD4AF37).withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Stack(
                        children:[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              "assets/images/resume.jpeg",
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 5,
                            right: 5,
                            child:Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              child: Icon(Icons.bar_chart_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          )
                        ]
                    ),
                    const SizedBox(width: 15),

                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Chapter 2',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 6),

                          Text('Verse 47' ,
                            style: TextStyle(
                                color: Colors.white70
                            ),
                          ),

                          const SizedBox(height: 10),

                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: const Color(0xffF6C344),
                              inactiveTrackColor:  Colors.white24,
                              thumbColor: const  Color(0xffF6C344),
                              overlayShape: SliderComponentShape.noOverlay,
                              thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 6,
                              ),
                              trackHeight: 4,
                            ),
                            child: Slider(value: progress,
                                min: 0,
                                max: 1,
                                onChanged:(value){
                                  setState(() {
                                    progress = value;
                                  });
                                }),
                          )
                        ],
                      ),
                    ),
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: const Color(0xffF6C344),
                      child: Icon(Icons.play_arrow_rounded,
                        color: Colors.black,),
                    )
                  ],
                ),
              ),

              SizedBox(height: 25),

              Padding(
                padding: const EdgeInsets.all(12),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("All Chapters" ,
                    style: TextStyle(
                      color: Color(0xffD4AF37),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 5),

              ChapterCard(
                number: "01",
                title: "Arjuna Vishada Yoga",
                verses: "47 Verses",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChapterDetailScreen(
                        chapter: Chapter(
                          number: 01,
                          title: "Arjuna Vishada Yoga",
                          subtitle: "The Yoga of Arjuna's Grief",
                          verseCount: 47,
                        ),
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: 5),

              ChapterCard(
                number: "02",
                title: "Sankhya Yoga",
                verses: "72 Verses",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChapterDetailScreen(
                        chapter: Chapter(
                          number: 02,
                          title: "Sankhya Yoga",
                          subtitle: "The Yoga of Knowledge",
                          verseCount: 72,
                        ),
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: 5),

              ChapterCard(
                number: "03",
                title: "Karma Yoga ",
                verses: "43 Verses",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChapterDetailScreen(
                        chapter: Chapter(
                          number: 03,
                          title: "Karma Yoga",
                          subtitle: "The Yoga of Action",
                          verseCount: 43,
                        ),
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: 5),

              ChapterCard(
                number: "04",
                title: "Jnana Karma Sanyasa Yoga",
                verses: "42 Verses",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChapterDetailScreen(
                        chapter: Chapter(
                          number: 04,
                          title: "Jnana Karma Sanyasa Yoga",
                          subtitle: "The Yoga of Knowledge and Renunciation of Action",
                          verseCount: 42,
                        ),
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: 5),

              ChapterCard(
                number: "05",
                title: "Sankhya Yoga",
                verses: "29 Verses",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChapterDetailScreen(
                        chapter: Chapter(
                          number: 05,
                          title: "Karma Sanyasa Yoga",
                          subtitle: "The Yoga of Renunciation",
                          verseCount: 29,
                        ),
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: 5),

              ChapterCard(
                number: "06",
                title: "Atma Samyama Yoga",
                verses: "47 Verses",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChapterDetailScreen(
                        chapter: Chapter(
                          number: 06,
                          title: "Atma Samyama Yoga",
                          subtitle: "The Yoga of Self-Control",
                          verseCount: 47,
                        ),
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: 5),

              ChapterCard(
                number: "07",
                title: " Jnana Vijnana Yoga",
                verses: "30 Verses",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChapterDetailScreen(
                        chapter: Chapter(
                          number: 07,
                          title: "Jnana Vijnana Yoga",
                          subtitle: "The Yoga of Knowledge and Wisdom",
                          verseCount: 30,
                        ),
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: 5),

              ChapterCard(
                number: "08",
                title: " Akshara Brahma Yoga",
                verses: "28 Verses",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChapterDetailScreen(
                        chapter: Chapter(
                          number: 08,
                          title: "Akshara Brahma Yoga",
                          subtitle: "The Yoga of the Imperishable Absolute",
                          verseCount: 28,
                        ),
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: 5),

              ChapterCard(
                number: "09",
                title: "Raja Vidya Raja Guhya Yoga",
                verses: "34 Verses",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChapterDetailScreen(
                        chapter: Chapter(
                          number: 09,
                          title: "Raja Vidya Raja Guhya Yoga",
                          subtitle: "The Yoga of Royal Knowledge and Royal Secret",
                          verseCount: 34,
                        ),
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: 5),

              ChapterCard(
                number: "10",
                title: "Vibhuti Yoga",
                verses: "42 Verses",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChapterDetailScreen(
                        chapter: Chapter(
                          number: 10,
                          title: "Vibhuti Yoga",
                          subtitle: "The Yoga of Divine Glories",
                          verseCount: 42,
                        ),
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: 5),

              ChapterCard(
                number: "11",
                title: "Vishvarupa Darshana Yoga",
                verses: "55 Verses",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChapterDetailScreen(
                        chapter: Chapter(
                          number: 11,
                          title: "Vishvarupa Darshana Yoga",
                          subtitle: "The Yoga of the Vision of the Universal Form",
                          verseCount: 55,
                        ),
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: 5),

              ChapterCard(
                number: "12",
                title: "Bhakti Yoga",
                verses: "20 Verses",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChapterDetailScreen(
                        chapter: Chapter(
                          number: 12,
                          title: "Bhakti Yoga",
                          subtitle: "The Yoga of Devotion",
                          verseCount: 20,
                        ),
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: 5),

              ChapterCard(
                number: "13",
                title: "Kshetra Kshetrajna Vibhaga Yoga ",
                verses: "34 Verses",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChapterDetailScreen(
                        chapter: Chapter(
                          number: 13,
                          title: "Kshetra Kshetrajna Vibhaga Yoga",
                          subtitle: "The Yoga of the Field and the Knower of the Field",
                          verseCount: 34,
                        ),
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: 5),

              ChapterCard(
                number: "14",
                title: "Gunatraya Vibhaga Yoga",
                verses: "27 Verses",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChapterDetailScreen(
                        chapter: Chapter(
                          number: 14,
                          title: "Gunatraya Vibhaga Yoga",
                          subtitle: "The Yoga of the Division of the Three Gunas",
                          verseCount: 27,
                        ),
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: 5),

              ChapterCard(
                number: "15",
                title: "Purushottama Yoga",
                verses: "20 Verses",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChapterDetailScreen(
                        chapter: Chapter(
                          number: 15,
                          title: "Purushottama Yoga",
                          subtitle: "The Yoga of the Supreme Person",
                          verseCount: 20,
                        ),
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: 5),

              ChapterCard(
                number: "16",
                title: " Daivasura Sampad Vibhaga Yoga",
                verses: "24 Verses",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChapterDetailScreen(
                        chapter: Chapter(
                          number: 16,
                          title: "Daivasura Sampad Vibhaga Yoga",
                          subtitle: "The Yoga of the Division between the Divine and the Demoniac",
                          verseCount: 24,
                        ),
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: 5),

              ChapterCard(
                number: "17",
                title: " Shraddhatraya Vibhaga Yoga",
                verses: "28 Verses",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChapterDetailScreen(
                        chapter: Chapter(
                          number: 17,
                          title: "Shraddhatraya Vibhaga Yoga",
                          subtitle: "The Yoga of the Division of the Threefold Faith",
                          verseCount: 28,
                        ),
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: 5),

              ChapterCard(
                number: "18",
                title: "Moksha Sanyasa Yoga",
                verses: "78 Verses",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChapterDetailScreen(
                        chapter: Chapter(
                          number: 18,
                          title: "Moksha Sanyasa Yoga",
                          subtitle: "The Yoga of Liberation through Renunciation",
                          verseCount: 78,
                        ),
                      ),
                    ),
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}