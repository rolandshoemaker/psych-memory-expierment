10 noclear = 0
500 window 6,26,340,63
1000  let t5 = time
1002        rem ********set window 0,100,0,100
1004       rem ******* set cursor 10,1
1006       rem ******* set curson "OFF"
1008   dim tipe(60),target$(60),z(6,3),z1(6,3)
1009 dim nosubj(6),rtime(60),recog$(60),rf(60)
1010 dim tform$(60),fform$(60),trhyme$(60),frhyme$(60),tcateg$(60),fcateg$(60)
1012        dim distract$(60),a1(2),s2(60),sd2(60),s3(6),t(60),d$(60),targ$(60)
1014        dim recog(60),eror(60),eror$(60),rerror$(60),wrong$(60)
1016        dim target(60),distract(60)
1018  rem ******************randomize
1020 let q1$ = " IS A "
1022        let q2$ = " RHYMES WITH "
1024        let q3$ = " IS "
1026        let a1(1) = 60
1028        let a1(2) = 60
1052 call signin : call instruct
1054        call present
1056 call recognize
1058        call analysis
1059 rem ----------------------------------
1060 sub signin()
1061 cls : print : print : print : print : print "Type your first and last name, then press return"; : input nam$
1062 for n = 1 to 60 : read target$(n) : next n
1064 for n = 1 to 60 : read distract$(n) : next n
1100 print
1110 print
1120 print "Before we begin, there are some instructions."
1130 print "Read them carefully so that you understand the task." : print : print
1140 for n = 1 to 60
1150 read tipe(n)
1160 next n
1170 for n = 1 to 60
1180 read tform$(n)
1190 next n
1200 for n = 1 to 60
1210 read fform$(n)
1220 next n
1230 for n = 1 to 60
1240 read trhyme$(n)
1250 next n
1260 for n = 1 to 60
1270 read frhyme$(n)
1280 next n
1290 for n = 1 to 60
1300 read tcateg$(n)
1310 next n
1320 for n = 1 to 60
1330 read fcateg$(n)
1340 next n
1350 call retur
1360 end sub
1402 rem -------------------------------
1490 rem -------------------------------
1500 sub instruct()
1510 cls : print
1520 print : print : print
1530 print "You are going to answer 3 kinds of questions about certain words"
1540 print
1560 print " - Does it RHYME with (some word)?"
1570 print " - Is it a (some category label)?"
1575 print " - Is it a CVCV (consonant, vowel, consonant, vowel)?"
1580 print
1590 print "One of these questions will appear, followed by a single word."
1600 print "At that point, you'll respond 'yes' or 'no' depending on"
1610 print "  which is correct.  (Examples follow.)"
1620 print
1630 call retur
1640 print : print : print : print
1650 print "If the first question is 'Rhymes with log?,"
1652 print " press the Y-key if the next word rhymes with log,"
1654 print " and the N-key if it doesn't."
1670 print
1680 print "In either case, respond as quickly as possible, but be accurate."
1690 print
1700 print "Follow the same procedure if the question is of the form:"
1710 print "  'is a type of tree'.  You'd hit the Y-key if the next"
1720 print "   word was maple, and the N-key if the next was mouse."
1730 print
1740 print "Again, respond quickly, but try to answer correctly."
1750 print
1760 print "For the third type of question, you'll see a string of v's and c's"
1770 print "  v stands for vowel (A, E, I, O, U, Y)"
1780 print "  c stands for consonant."
1790 print
1800 print "And so, if you see 'is a CVC?', you'd hit the Y-key if the next word was dog"
1810 print "  If you saw 'is a vccvv,', you'd hit the N-key if the next word was apple."
1820 print
1830 print "As with the other questions, respond quickly but accurately."
1840 print : call retur
1850 cls : print : print : print : print
1860 print "Once again: if the answer to any question is YES, press the Y-key,"
1870 print " but if the answer is NO, press the N-key."
1880 print
1890 print
1900 call inpu
1920 end sub
1930 sub inpu()
1960 print " If you understand the procedure, press 'Y'."
1970 print
1980 print " Press 'N' to review instructions.";
1990 get r$
2000 if r$ = "N" or r$ = "n" then call instruct
2010 if r$ = "Y" or r$ = "y" then 2030
2015 print b
2020 goto 1990
2030 print
2032 print " Press 's' to start.";
2034 get r$
2036 if r$ <> "s" then goto 2034
2037 call pause()
2038 end sub
2040 rem--------------------------------
2050 sub present()
2060 let wrong = 1
2070 for b = 1 to 60
2080 select case tipe(b)
2090 case 1
2095 call categoryf
2100 case 2
2110 call rhymef
2120 case 3
2130 call formf
2140 case 4
2150 call formt
2160 case 5
2170 call rhymet
2180 case 6
2190 call categoryt
2200 end select
2210 let t(b) = tipe(b)
2220 next b
2230 end sub
2240 rem-----------------------
2250 sub categoryf()
2260 let show$ = q3$+fcateg$(b) : call gosuf
2270 end sub
2280 rem------------------------
2290 sub rhymef()
2300 let show$ = q2$+frhyme$(b) : call gosuf
2310 end sub
2320 rem ---------
2330 sub formf()
2340 let show$ = q1$+fform$(b) : call gosuf
2350 end sub
2360 rem -------------
2370 sub formt()
2380 let show$ = q1$+tform$(b) : call gosut
2390 end sub
2400 rem -------------
2410 sub rhymet()
2420 let show$ = q2$+trhyme$(b) : call gosut
2430 end sub
2440 rem --------------
2450 sub categoryt()
2460 let show$ = q3$+tcateg$(b) : call gosut
2470 end sub
2480 rem ---------------
2490 rem ---------------
2500 sub gosuf()
2510 call presentitem()
2520 call pause
2530 call tallyf
2540 end sub
2550 rem ---------------
2600 sub gosut()
2610 call presentitem()
2620 call pause
2630 call tallyt
2640 end sub
2650 rem ----------------
3000 data "speech","brush","cheek","fence","flame","flour","honey","knife","sheep","copper","glove"
3010 data "monk","daisy","miner","cart","clove","robber","mast","fiddle","chapel","sonnet","witch"
3020 data "roach","brake","twig","grin","drill","moan","claw","singer","bear","lamp","cherry","rock","earl"
3030 data "pool","week","boat","pail","trout","gram","wool","clip","juice","pond","lane","nurse","lark"
3040 data "state","soap","jade","sleet","rice","tire","child","dance","field","floor","glass","tribe"
3050 rem ----- and now the distractor items
3060 data "boiler","activity","love","small","same","rug","ski","book","bug","cook","teeth","ruler"
3070 data "ham","turtle","skirt","church","bird","secret","lemon","needle","yard","rake","swim","today"
3080 data "tape","patch","skate","night","crab","type","egg","wood","stove","ice","chew","bed"
3090 data "grape","engine","thumb","train","black","cold","ground","jam","doctor","light","white","test"
3100 data "ranch","noise","bowl","lip","gem","purse","phone","chair","towel","finger","note","meter"
3200 rem
3210 rem -----------------  order of trial types
3230 data 2,1,4,6,5,3,1,2,4,2,5,1,4,2,4,1,1,6,3,2,3,5,6,4,3,5,5,6,3,6,2,1,4,6
3240 data 5,3,1,2,4,2,6,1,4,2,4,1,1,5,3,2,3,5,6,4,2,5,5,6,3,6
3260 rem ------------------------- forms
3300 data "ccvvcc","ccvcc","ccvvc","cvccv","ccvcv","ccvvc"
3310 data "cvcvv","ccvcv","ccvvc","cvccvc","ccvcv","cvcc","cvvcv"
3320 data "cvcvc","cvcc","ccvcv","cvccvc","cvcc","cvcccv","ccvcvc"
3330 data "cvccvc","cvccc","cvvcc","ccvcv","ccvc","ccvc","ccvcc"
3340 data "cvvc","ccvc","cvccvc","cvvc","cvcc","ccvccv","cvcc"
3350 data "vvcc","cvvc","cvvc","cvvc","cvvc","ccvvc","ccvc"
3360 data "cvvc","ccvc","cvvcv","cvcc","cvcv","cvccv","cvcc"
3370 data "ccvcv","cvvc","cvcv","ccvvc","cvcv","cvcv","ccvcc"
3380 data "cvccv","cvvcc","ccvvc","ccvcc","ccvcv","cvcvcc"
3390 data "cccvc","ccvcv","ccvcv","cccvv","cvcvc","cvccv","ccvvc"
3400 data "cvcvc","cvvccc","ccvvc","ccvc","cvcvv","ccvvc","ccvc"
3410 data "ccvvc","ccvcvc","ccvc","ccvccv","ccvvcc","ccvcvc"
3420 data "ccvcc","cvcvc","ccvvc","cvcc","cvcc","cvccc","cvcv"
3430 data "cvcc","cvcvcc","cvcv","ccvc","cccvcv","ccvc","vcvc"
3440 data "cvcv","ccvv","cvcv","cvcv","ccvcv","cvcc","ccvv"
3450 data "cvcc","cvcvv","ccvc","cvvc","cvcvc","ccvc","cvccv"
3460 data "cvcv","cvvc","cvcvc","cvvc","cvvc","cccvc","ccvcv"
3470 data "cvcvc","ccvcv","cvccc","cccvv"
3500 rem ---------------------------rhymes, true then false
3510 data "each","lush","teak","tense","claim","sour","funny"
3520 data "wife","leap","stopper","shove","trunk","crazy"
3530 data "liner","start","rove","clobber","past","riddle"
3540 data "grapple","bonnet","rich","coach","shake","big","bin"
3550 data "fill","prone","raw","ringer","hair","camp","very"
3560 data "stock","pearl","school","peak","rote","whale","bout"
3570 data "tram","pull","ship","noose","wand","pain","curse"
3580 data "park","crake","rope","raid","feet","dice","fire"
3590 data "wild","stance","shield","sore","pass","scribe"
3600 data "angle","cabin","detail","elbow","mercy","muscle","bubble"
3610 data "elder","jewel","merit","penny","turkey","acid"
3620 data "career","devil","fury","lily","stable","acre"
3630 data "coffee","cradle","journey","public","tiger","diet"
3640 data "hotel","linen","navy","pupil","wagon","candy","duty"
3650 data "total","scholar","human","maker","arrow","vapor","echo"
3660 data "leather","cotton","robber","basis","patent","cellar"
3670 data "body","color","item","lover","velvet","robin"
3680 data "money","hero","novel","wedding","habit","column"
3690 data "organ","spider","parcel"
3700 rem -------------------------
3710 data "a form of communication","things used for cleaning"
3720 data "a part of the body","thing found in the garden"
3730 data "something hot","things used for cooking"
3740 data "a type of food","a type of weapon"
3750 data "something to wear","a type of clergy"
3760 data "a type of farm animal","a type of metal"
3770 data "a type of flower","a type of occupation"
3780 data "a type of vehicle","a type of herb"
3810 data "a type of criminal","a part of a ship"
3820 data "a musical instrument","a type of building"
3830 data "a written form of art","thing associated with magic"
3840 data "a type of insect","a part of a coat"
3850 data "a part of a tree","a human expression"
3860 data "a type of implement","a human sound"
3870 data "a part of an animal","a type of entertainer"
3880 data "a wild animal","a type of furniture"
3890 data "a type of fruit","found outdoors"
3900 data "a type of nobility","a type of game"
3910 data "a division of time","a mode of travel"
3920 data "a type of container","a type of fish"
3930 data "a type of measurement","a type of material"
3940 data "a type of office supply","a type of beverage"
3950 data "a body of water","a type of thoroughfare"
3960 data "people in medicine","a type of bird"
3970 data "a territorial unit","a type of toiletry"
3980 data "a type of precious stone","a type of weather"
3990 data "a type of grain","a round object"
4000 data "a human being","a type of physical activity"
4010 data "things in the countryside","a part of a room"
4020 data "a type of utensil","a group of people"
4025 rem-------
4030 data "a political unit","a type of silverware"
4040 data "a part of a house","thing that floats in the air"
4050 data "a type of mental activity","a type of snake"
4060 data "a rigid object","a wild vegetable"
4070 data "a type of cloud","woven cloth"
4080 data "mining tools","boundary dispute"
4090 data "a type of ant","a type of surgery"
4100 data "a type of park","a container for liquid"
4110 data "something sold on street corners","a type of gas"
4120 data "a type of weight","a part of a crab"
4130 data "a type of accident","a train sound"
4140 data "part of a watch","a Monopoly token"
4150 data "a name of a state","a type of medal"
4160 data "a type of fertilizer","a type of wild berry"
4170 data "a type of evergreen tree","a barnyard creature"
4175 data "a type of television show","a part of the foot"
4180 data "a kind of gesture","a type of farmer's clothing"
4190 data "a thing that makes you smile","a part of a leaf"
4200 data "a part of an airplane","a type of eagle"
4210 data "people in the circus","a figure of speech"
4220 data "a type of ancient architecture","a type of vocal music"
4230 data "a type of wave","a type of police weapon"
4240 data "a type of shrub","a type of church"
4250 data "a part of a bicycle","a type of hobby"
4260 data "a type of weed","things you do at camp"
4270 data "a type of varnish","a type of joke"
4280 data "a type of mood","something used for washing"
4290 data "something shiny","a type of pet"
4300 data "a type of sport","something that makes light"
4310 data "a type of lock","a quantity of paper"
5000 rem ------- sub getdisp
5010 sub getdisp()
5020 r = 110
5025 if rr$ = "y" then r = 121
5030 if rr$ = "Y" then r = 121
5070 call pause
5075 end sub
5080  print "Y"
5090 r = 121
5100 rem --------------------------------------sub pause
5101 sub pause()
5102 for x = 1 to 100000 : next x
5104 end sub
5150 rem -----------sub retur
5155 sub retur() : print "Press the number 1 to go on:"
5160 get kk$
5165 if kk$ <> "1" then 5160
5170 if noclear = 0 then cls
5180 end sub
5200 rem ---------------sub presentitem
5210 sub presentitem()
5220 cls : gotoxy 15,20 : print show$
5230 start = timer : r = 110
5235 dur = timer
5238 if dur-start < 3 then goto 5235
5240 cls : gotoxy 17,20 : print "> ";target$(b);";";
5250 let t1 = timer
5260 get r$
5270 if r$ = "Y" or r$ = "y" then r = 121
5280 rt = timer-t1
5290 cls : end sub
5400 rem ----------------Tallyf
5402 rem ------ both tallyf and tally t z(x,y) is
5404 rem ------ x 1 for fact, 2 frhyme; 3 fform; 4 tform; 5 trhyme;6 tcat
5406 rem ------ y 1 encoding # correct; 2 RT encoding; 3 recog for that type
5410 sub tallyf()
5412 if r = 110 then let z(tipe(b),1) = z(tipe(b),1)+1
5414 let z(tipe(b),2) = z(tipe(b),2)+rt : end sub
5416 sub tallyt()
5418 if r = 121 then let z(tipe(b),1) = z(tipe(b),1)+1 : rem tallies correct trues
5419 let z(tipe(b),2) = z(tipe(b),2)+rt : end sub
5420 rem -------------Sub recognize
5422 sub recognize() : cls
5424 print : print : print : for iii = 1 to 32000000 : next iii
5430 print "The first part of the experiment is now done."
5440 print : print "In the next part of the experiment, we will test your memory." : print
5450 print "You're about to see a series of words, one by one, and your job is" : print " to decide which ";
5460 print " ones appeared in the first part of the experiment."
5470 print
5480 print "Words will appear, followed by a '?' " : print
5490 print "If it is a word you remember seeing earlier in the experiment,"
5500 print " then press the Y-key.  If you do not recognize the word,"
5510 print " then press the N-key."
5520 print : print "Speed is not important, take your time and be"
5530 print " as ACCURATE as you can."
5540 print : call retur : 
5545 rem ------ And now starts the test
5550 for xx = 1 to 120
5560 let r = int(2*rnd(1),0)+1
5570 if r = 1 then 5610 : rem   if we choose a target....
5580 if a1(2) = 0 then 5610 : rem   if we chose distraction, but all used up...
5590 call distrec : rem     This is what we want if we chose distract and not all gone.
5600 goto 5660 : rem   Having shown a distractor, leave the loop
5610 if a1(1) = 0 then 5590 : rem targets all gone, then show distractor instead
5620 call targrec : rem   if chose target, and passed 5610's test, then show targ
5660 next xx
5670 let t6 = timer : rem  This ends the timing for the whole session
5680 let tt = t6-t5
5690 end sub
5700 rem -----------------------Targrec
5705 sub targrec()
5710 let display$ = target$(a1(1))
5720 cls : gotoxy 17,20 : print "> ";display$
5730 get rr$ : call getdisp
5740 if r = 121 then call recogn : rem  If r = 121 then y is correct
5750 let a1(1) = a1(1)-1 : end sub
5800 rem -----------------------Distrec
5805 sub distrec()
5810 let display$ = distract$(a1(2))
5820 cls : gotoxy 17,20 : print "> ";display$
5830 get rr$ : call getdisp
5840 if r = 121 then call falserecog : rem  If r = 121 then y is incorrect
5850 let a1(2) = a1(2)-1 : end sub
5900 rem ---------------------recogn
5905 sub recogn()
5910 call tallyr
5920 let rr = rr+1 : rem this allows 1 to rr command to list, in the end, the recog'ed words
5930 let recog$(rr) = display$
5940 end sub
6000 rem -------------------false recog
6010 sub falserecog()
6020 let e = e+1 : rem this allows 1 to e to print all FALSE recog
6030 let eror$(e) = display$
6040 end sub
6050 rem ----------------tally r
6060 sub tallyr() : rem tallies correctly recognized words
6070 let z(t(a1(1)),3) = z(t(a1(1)),3)+1
6080 end sub
7000 rem --------------------------sub analysis
7010 sub analysis()
7020 call timean
7025 cls : for iii = 1 to 31000000 : next iii
7026 for iii = 1 to 6 : z(iii,2) = int(z(iii,2)*100)/100 : next iii
7028 print : print : print : print "You're done -- and here is a data summary."
7030 print "     Question Type","Encoding","Response","Recognized"
7040 print " "," "," ","# Crrct"," ","  Time"," "," In test" : print
7050 print "       True, form",;
7055 print z(4,1)," ",z(4,2)," ",z(4,3)
7070 print "       False, form",;
7072 print z(3,1)," ",z(3,2)," ",z(3,3)
7080 print : print : print "       True, rhyme",;
7082 print z(5,1)," ",z(5,2)," ",z(5,3)
7085 print "       False, rhyme",;
7090 print z(2,1)," ",z(2,2)," ",z(2,3)
7100 print : print : print "       True, category",;
7105 print z(6,1)," ",z(6,2)," ",z(6,3)
7110 print "       False, category",;
7115 print z(1,1)," ",z(1,2)," ",z(1,3)
7120 print : print "False recognitions: ";e
7130 call ending
7160 print
7170 print "The purpose of this experiment was to compare your memory for words"
7175 print " encoded in three different ways: FORM encoding, RHYME encoding, and CATEGORY encoding"
7180 print : print "There were 20 trials of each type (10 true, 10 false)." : print
7185 print "The prediction was that words encoded at a 'deeper'"
7190 print " (more meaningful) level should be more easily remembered." : print
7195 print "In the 'encoding crrct' column, your scores should be near 10 - the"
7196 print " encoding questions were easy!" : print : 
7200 print "Our main predictions, though, were for the 'Recognized in test' column, and here"
7210 print " we predict that you would remember more of the category words (lower rows) than"
7215 print " rhyme words (middle rows), and more of those than form words, EVEN THOUGH"
7220 print " your response times for the form words during encoding were longest (and so"
7230 print " the form words were actually in your view, during encoding, for more time"
7240 print " than the words in other conditions.)" : print
7242 print : print "How do your recognition scores compare for 'true' and 'false' items?"
7244 print : print " If there's a pattern, what causes the pattern?" : print
7250 print "You weren't supposed to be aware that there was a memory test at the end"
7260 print " but you may well have guessed.  We should think about how this may have"
7270 print " have influenced the results!" : print
7280 print "Let's try not to alert other people to the memory test, though, and so"
7290 print " please don't tell your friends about the experiment until they've finished"
7300 print " running themselves." : print : print "Thank you!  And you're  DONE. "
7305 print : let noclear = 0 : call retur
7340 end sub
7400 rem ----------------------------- Sub timean
7410 sub timean()
7420 for x = 1 to 6 : let z(x,2) = z(x,2)/10 : next x
7430 end sub
7440 rem -------------------------------------- sub datsave
7450 sub finishit(decide$)
7455 call timean
7456 for iii = 1 to 6 : z(iii,2) = int(z(iii,2)*100)/100 : next iii
7460 rem if decide$ = "2" then open "SFPutFile" for output as #1
7465 rem if decide$ = "1" then open "print.temp" for output as #1
7468 open "print.temp" for output as #1
7470 print #1,"     Question Type","Encoding","Response","Recognized"
7480 print #1," "," "," ","# Crrct"," ","  Time"," "," In test" : print #1
7490 print #1,"       True, form",;
7500 print #1,z(4,1)," ",z(4,2)," ",z(4,3)
7510 print #1,"       False, form",;
7522 print #1,z(3,1)," ",z(3,2)," ",z(3,3)
7530 print #1, : print #1, : print #1,"       True, rhyme",;
7542 print #1,z(5,1)," ",z(5,2)," ",z(5,3)
7555 print #1,"       False, rhyme",;
7560 print #1,z(2,1)," ",z(2,2)," ",z(2,3)
7570 print #1, : print #1, : print #1,"       True, category",;
7585 print #1,z(6,1)," ",z(6,2)," ",z(6,3)
7590 print #1,"       False, category",;
7615 print #1,z(1,1)," ",z(1,2)," ",z(1,3)
7620 print #1, : print #1,"False recognitions: ";e
7630 close #1
7640 rem if decide$ = "1" then sys("lpr print.temp; wait $1; rm print.temp")
7650 sys("lpr print.temp; wait $1; rm print.temp")
7850 end sub
8200 rem -------------------------------- sub ending
8210 sub ending()
8220 print "Would you like to save or print?"
8230 print "	1: Print"
8240 print "	2: Save"
8250 get rr$
8255 if rr$ <> "1" and rr$ <> "2" then goto 8250
8260 call finishit(rr$)
8270 end sub
8280 end
