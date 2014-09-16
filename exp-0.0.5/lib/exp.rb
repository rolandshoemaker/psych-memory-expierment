#!/usr/bin/ruby -w
# exp.rb - Psych Experiment for Daniel Reisberg
# port from Chipmunk Basic to Ruby by Roland Shoemaker - 2011

# Requires
require 'rubygems'
require 'tempfile'
require 'highline/system_extensions'
include HighLine::SystemExtensions

# Data arrays
$order = [2,1,4,6,5,3,1,2,4,2,5,1,4,2,4,1,1,6,3,2,3,5,6,4,3,5,5,6,3,6,2,1,4,6,5,3,1,2,4,2,6,1,4,2,4,1,1,5,3,2,3,5,6,4,2,5,5,6,3,6]
$target = ['speech','brush','cheek','fence','flame','flour','honey','knife','sheep','copper','glove','monk','daisy','miner','cart','clove','robber','mast','fiddle','chapel','sonnet','witch','roach','brake','twig','grin','drill','moan','claw','singer','bear','lamp','cherry','rock','earl','pool','week','boat','pail','trout','gram','wool','clip','juice','pond','lane','nurse','lark','state','soap','jade','sleet','rice','tire','child','dance','field','floor','glass','tribe']
$targetors = 61
$distract = ['boiler','activity','love','small','same','rug','ski','book','bug','cook','teeth','ruler','ham','turtle','skirt','church','bird','secret','lemon','needle','yard','rake','swim','today','tape','patch','skate','night','crab','type','egg','wood','stove','ice','chew','bed','grape','engine','thumb','train','black','cold','ground','jam','doctor','light','white','test','ranch','noise','bowl','lip','gem','purse','phone','chair','towel','finger','note','meter']
$distractors = 61
$falserecog = []
$formtrue = ['ccvvcc','ccvcc','ccvvc','cvccv','ccvcv','ccvvc','cvcvv','ccvcv','ccvvc','cvccvc','ccvcv','cvcc','cvvcv','cvcvc','cvcc','ccvcv','cvccvc','cvcc','cvcccv','ccvcvc','cvccvc','cvccc','cvvcc','ccvcv','ccvc','ccvc','ccvcc','cvvc','ccvc','cvccvc','cvvc','cvcc','ccvccv','cvcc','vvcc','cvvc','cvvc','cvvc','cvvc','ccvvc','ccvc','cvvc','ccvc','cvvcv','cvcc','cvcv','cvccv','cvcc','ccvcv','cvvc','cvcv','ccvvc','cvcv','cvcv','ccvcc','cvccv','cvvcc','ccvvc','ccvcc','ccvcv']
$formfalse = ['cvcvcc','cccvc','ccvcv','ccvcv','cccvv','cvcvc','cvccv','ccvvc','cvcvc','cvvccc','ccvvc','ccvc','cvcvv','ccvvc','ccvc','ccvvc','ccvcvc','ccvc','ccvccv','ccvvcc','ccvcvc','ccvcc','cvcvc','ccvvc','cvcc','cvcc','cvccc','cvcv','cvcc','cvcvcc','cvcv','ccvc','cccvcv','ccvc','vcvc','cvcv','ccvv','cvcv','cvcv','ccvcv','cvcc','ccvv','cvcc','cvcvv','ccvc','cvvc','cvcvc','ccvc','cvccv','cvcv','cvvc','cvcvc','cvvc','cvvc','cccvc','ccvcv','cvcvc','ccvcv','cvccc','cccvv']
$truerhyme = ['each','lush','teak','tense','claim','sour','funny','wife','leap','stopper','shove','trunk','crazy','liner','start','rove','clobber','past','riddle','grapple','bonnet','rich','coach','shake','big','bin','fill','prone','raw','ringer','hair','camp','very','stock','pearl','school','peak','rote','whale','bout','tram','pull','ship','noose','wand','pain','curse','park','crake','rope','raid','feet','dice','fire','wild','stance','shield','sore','pass','scribe']
$falserhyme = ['angle','cabin','detail','elbow','mercy','muscle','bubble','elder','jewel','merit','penny','turkey','acid','career','devil','fury','lily','stable','acre','coffee','cradle','journey','public','tiger','diet','hotel','linen','navy','pupil','wagon','candy','duty','total','scholar','human','maker','arrow','vapor','echo','leather','cotton','robber','basis','patent','cellar','body','color','item','lover','velvet','robin','money','hero','novel','wedding','habit','column','organ','spider','parcel']
$truecat = ['a form of communication','things used for cleaning','a part of the body','thing found in the garden','something hot','things used for cooking','a type of food','a type of weapon','something to wear','a type of clergy','a type of farm animal','a type of metal','a type of flower','a type of occupation','a type of vehicle','a type of herb','a type of criminal','a part of a ship','a musical instrument','a type of building','a written form of art','thing associated with magic','a type of insect','a part of a coat','a part of a tree','a human expression','a type of implement','a human sound','a part of an animal','a type of entertainer','a wild animal','a type of furniture','a type of fruit','found outdoors','a type of nobility','a type of game','a division of time','a mode of travel','a type of container','a type of fish','a type of measurement','a type of material','a type of office supply','a type of beverage','a body of water','a type of thoroughfare','people in medicine','a type of bird','a territorial unit','a type of toiletry','a type of precious stone','a type of weather','a type of grain','a round object','a human being','a type of physical activity','things in the countryside','a part of a room','a type of utensil','a group of people']
$falsecat = ['a political unit','a type of silverware','a part of a house','thing that floats in the air','a type of mental activity','a type of snake','a rigid object','a wild vegetable','a type of cloud','woven cloth','mining tools','boundary dispute','a type of ant','a type of surgery','a type of park','a container for liquid','something sold on street corners','a type of gas','a type of weight','a part of a crab','a type of accident','a train sound','part of a watch','a Monopoly token','a name of a state','a type of medal','a type of fertilizer','a type of wild berry','a type of evergreen tree','a barnyard creature','a type of television show','a part of the foot','a kind of gesture','a type of farmer\'s clothing','a thing that makes you smile','a part of a leaf','a part of an airplane','a type of eagle','people in the circus','a figure of speech','a type of ancient architecture','a type of vocal music','a type of wave','a type of police weapon','a type of shrub','a type of church','a part of a bicycle','a type of hobby','a type of weed','things you do at camp','a type of varnish','a type of joke','a type of mood','something used for washing','something shiny','a type of pet','a type of sport','something that makes light','a type of lock','a quantity of paper']
$questions = [' IS A ',' RHYMES WITH ',' IS ']
$qorder = [2, 1, 0, 0, 1, 2]
$qtorder = [$falsecat, $falserhyme, $formfalse, $formtrue, $truerhyme, $truecat]
$score = Array.new(6) {Array.new(3) {0}}

# Subroutines
def clear_scrn
	puts "\e[H\e[2J"
end

def wait_for_start
	loop do
		puts " Press 's' to start."
		what = get_character
		break if 's'[0].ord==what
	end
end
                                                                
def wait_for_one
	loop do
		puts "Press the number 1 to go on: "
		what = get_character
		break if '1'[0].ord==what
	end
end

def wait_for_yn
	loop do
		what = get_character
		return what.chr if 'y'[0].ord==what || 'n'[0].ord==what
		break if 'y'[0].ord==what || 'n'[0].ord==what
	end
end

def instructions
	loop do
		clear_scrn
		puts "Before we begin, there are some instructions.\nRead them carefully so that you understand the task."
		wait_for_one

		clear_scrn
		puts "You are going to answer 3 kinds of questions about certain words\n\n - Does it RHYME with (some word)?\n - Is it a (some category label)?\n - Is it a CVCV (constonant, vowel, constonant, vowel)?\n\nOne of these questions will appear, followed by a single word.\nAt that point, you\'ll respond \'yes\' or \'no\' depending on which is correct. (Examples follow)"
		wait_for_one

		clear_scrn
		puts "If the first question is \'Rhymes with log?\',\n Press the Y-key if the next word rhymes with log,\n and the N-key if it doesn\'t.\n\nIn either case, respond as quickly as possible, but be accurate.\n\nFollow the same procedure if the question is of the form:\n  \'is a type of tree\'. You\'d hit the Y-key if the next\n  word was maple, and the N-key if the next was mouse.\n\nAgain, respond quickly, but try to answer correctly.\n\nFor the third type of question, you\'ll see a string of v\'s and c\'s\n  v stands for vowel (A, E, I, O, U, Y)\n  c stands for constonant.\n\nAnd so, if you see \'is a CVC?\', you\'d hit the Y-key if the next word was dog\n  If you saw \'is a vccvv?\', you\'d hit the N-key if the next word was apple.\n\nAs with the other questions, respond quickly but accurately."
		wait_for_one

		clear_scrn
		puts "Once again: if the answer to any question is YES, press the Y-key,\n but if the answer is NO, press the N-key.\n\n"

		puts "If you understand the procedure, press \'y\'.\n Press \'n\' to review instructions."
		inp = wait_for_yn
		break if inp == 'y'
	end
end

def pause
  start = Time.now
  loop do
    break if (Time.now-start)>3
  end  
end

def scoring(ans, time, tf, n)
  if tf=='t'
    if ans=='y'
      $score[n][0] += 1
    end
    $score[n][1] += time
  elsif tf=='f'
    if ans=='n'
      $score[n][0] += 1
    end
    $score[n][1] += time
  end
end

def words(i, k)
  puts $questions[$qorder[(k-1)]]+$qtorder[(k-1)][i]
  pause
  clear_scrn
  puts $target[i]
  start = Time.now
  inp = wait_for_yn
  ends = Time.now
  if $order[i]>3
    tf='f'
  elsif $order[i]<4
    tf='t'
  end
  scoring(inp, (ends-start), tf, ($order[i]-1))
end

def distractor(i)
  k = (60-$distractors)
  print "> "+$distract[k]+" ?\n"
  inp = wait_for_yn
  if inp=='y'
    $falserecog.push($distract[k])
  end
  $distractors -= 1
end

def targetor(i)
  k = (60-$targetors)
  print "> "+$target[k]+" ?\n"
  inp = wait_for_yn
  if inp=='y'
    #cat = $order[k]
    #cat -= 1
    $score[($order[k]-1)][2] += 1
  end
  $targetors -= 1
end

$table = ['True form','False form','True rhyme','False Rhyme','True category','False category']
$torder =[3,2,4,1,5,0]
def print_score(file)
  format="%#{15}s\t%#{13}s\t\t%#{15}s\t\t\t%#{15}s\n"
  file.printf(format, "Group", "# Correct", "# Cumulative Response Time", "# Recognized in part 2")
  file.printf(format, "-----", "---------", "------------------------", "----------------------")
  for i in (0..5)
    file.printf(format, $table[i], "", "", "")
    file.printf(format, "", $score[i][0], $score[i][1], $score[i][2])
  end
  file.puts "False recognitions: "
  $falserecog.each do |item|
    file.puts item
  end
  wait_for_one
  return file
end

def print_or_save
  loop do
    puts "\n\n Would you like to save or print?\n  1: Print\n  2: Save\n  3: Save and Print\n  4: No action"
    resp = gets.chomp
    if resp=='1' || resp=='2' || resp=='3' || resp=='4'
      case resp
      when '1'
        path = save(0)
        system("lpr", path) or raise "lpr failed"
        break
      when '2'
        path = save(1)
        break
      when '3'
        path = save(1)
        system("lpr", path) or raise "lpr failed"
        break
      when '4'
        break
      end
    end
  end
end

def save(i)
  if i==0
    temp = Tempfile.new('random')
    temp = print_score(temp)
    temp.flush
    return temp.path 
  elsif i==1
    clear_scrn
    puts "Please enter a file name: "
    fn = gets.chomp
    savin = File.open(fn, 'w')
    savin = print_score(savin)
    puts "\n\n File saved to "+savin.path
    path = savin.path
    savin.close
    return path
  end
end 

# Main Program
clear_scrn
puts "Type your first and last name, then press return"
name = gets.chomp

instructions

clear_scrn
wait_for_start

for i in (0..59)
  clear_scrn
	words(i, $order[i])    
end

clear_scrn
puts "The first part of the experiment is now done.\nIn the next part of the experiment, we will test your memory.\nYou\'re about to see a series of words, one by one, and your job is to decide which ones appeared in the first part of the experiment.\n\nWords will appear, followed by a \'?\'\nIf it is a word you remember seeing earlier in the experiment, then press the Y-key.\n  If you do not recognize the word, then press the N-key.\nSpeed is not important, take your time and be as ACCURATE as you can."
wait_for_one

clear_scrn
for i in (0..119)
  r = rand(2)
  if r==0 && $distractors > 0
    distractor(i)
  elsif r==1 && $targetors > 0
    targetor(i)
  end
  if r==1 && $targetors == 0
    distractor(i)
  elsif r==0 && $distractors == 0
    targetor(i)
  end
end

clear_scrn
puts "You\'re done -- and here is a data summary."
print_score($stdout)

print_or_save
clear_scrn

puts "The purpose of this experiment was to compare your memory for words encoded in three different ways: FORM encoding, RHYME encoding, and CATEGORY encoding.\n There were 20 trials of each type (10 true, 10 false).\nThe prediction was that words encoded at a \'deeper\' (more meaningful) level should be more easily remembered.\nIn the '# Correct' column, your scores should be near 10 - the encoding questions were easy!\n\nOur main predictions, though, were for the 'Recognized in test' column, and here we predict that you would remember more of the category words (lower rows) than rhyme words (middle words), and more of those than form words, EVEN THOUGH your response times for the form words during encoding were longest (and so the form words were actually in your view, during encoding, for more time than the words in other conditions.)\n\nHow do your recognition scores compare for \'true\' and \'false\' items?\n\n If there\'s a pattern, what causes the pattern?\n\nYou weren't supposed to be away that there was a memory test at the end but you may well have guessed. We should think about how this may influenced the results!\n\nLet\'s try not to alert other people to the memory test, though, and so please don\'t tell your friends about the experiment untill they\'ve finished running it themselves.\n\n\n\ Thank you! And you\'re DONE."
