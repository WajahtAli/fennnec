import 'package:fennac_app/app/theme/app_emojis.dart';
import 'package:fennac_app/generated/assets.gen.dart';
import 'package:fennac_app/models/dummy/chat_message_model.dart';
import 'package:fennac_app/models/dummy/chat_room_model.dart';
import 'package:fennac_app/models/dummy/faq_item_model.dart';
import 'package:fennac_app/models/dummy/notification_tile_model.dart';
import 'package:fennac_app/models/dummy/pock_pack_model.dart';
import 'package:fennac_app/pages/home/data/models/groups_model.dart';

class DummyConstants {
  // Available options
  static final List<String> categories = [
    'Travel & Adventure',
    'Music & Arts',
    'Food & Drink',
    'Wellness & Lifestyle',
    'Sports & Outdoors',
    'Events & Parties',
    'Tech & Gaming',
    'Study & Learning',
  ];

  static final List<String> genders = [
    'Male',
    'Female',
    'Non-binary',
    'All genders',
  ];

  static final List<String> groupSizes = [
    'Max 3 people',
    'Max 5 people',
    'Max 10 people',
    'Any size',
  ];

  static final List<String> distances = [
    'Max 5 miles',
    'Max 10 miles',
    'Max 15 miles',
    'Max 25 miles',
    'Any distance',
  ];

  static final List<String> ageRanges = [
    '18 - 25 years old',
    '25 - 35 years old',
    '35 - 45 years old',
    '45 - 55 years old',
    '55+ years old',
  ];

  static final List<String> sexualOrientations = [
    'Straight',
    'Gay',
    'Lesbian',
    'Bisexual',
    'Pansexual',
    'Asexual',
    'Queer',
    'Questioning',
    'Prefer not to say',
  ];

  static final List<String> pronouns = [
    'He/Him',
    'She/Her',
    'They/Them',
    'He/They',
    'She/They',
  ];

  static final List<String> months = [
    'JAN',
    'FEB',
    'MAR',
    'APR',
    'MAY',
    'JUN',
    'JUL',
    'AUG',
    'SEP',
    'OCT',
    'NOV',
    'DEC',
  ];

  static final List<String> lifestyles = [
    'Adventure seeker ${AppEmojis.mountain}',
    'Coffee enthusiast ${AppEmojis.coffee}',
    'Foodie ${AppEmojis.plateWithCutlery}',
    'Gym lover ${AppEmojis.flexedBiceps}',
    'Dog parent ${AppEmojis.dogFace}',
    'Early riser ${AppEmojis.sunrise}',
    'Nature explorer ${AppEmojis.evergreenTree}',
    'Gamer ${AppEmojis.gameController}',
    'Cyclist ${AppEmojis.personBiking}',
    'Movie buff ${AppEmojis.movieCamera}',
  ];

  // Interest categories
  static final Map<String, List<String>> interestCategories = {
    'Sports & Outdoors': [
      '${AppEmojis.hiking} Hiking',
      '${AppEmojis.yoga} Yoga',
      '${AppEmojis.surfing} Surfing',
      '${AppEmojis.football} Football',
      '${AppEmojis.basketball} Basketball',
      '${AppEmojis.cycling} Cycling',
      '${AppEmojis.camping} Camping',
      '${AppEmojis.fishing} Fishing',
      '${AppEmojis.trailRunning} Trail Running',
      '${AppEmojis.snowboarding} Snowboarding',
      '${AppEmojis.musicFestivals} Music Festivals',
      '${AppEmojis.skiing} Skiing',
      '${AppEmojis.horseRiding} Horse Riding',
      '${AppEmojis.kayaking} Kayaking',
      '${AppEmojis.swimming} Swimming',
      '${AppEmojis.rockClimbing} Rock Climbing',
    ],
    'Food & Drink': [
      '${AppEmojis.coffeeLover} Coffee Lover',
      '${AppEmojis.sushiNights} Sushi Nights',
      '${AppEmojis.pizzaFridays} Pizza Fridays',
      '${AppEmojis.wineTasting} Wine Tasting',
      '${AppEmojis.foodTruck} Street Food Explorer',
      '${AppEmojis.cupcake} Baking',
      '${AppEmojis.taco} Taco Enthusiast',
      '${AppEmojis.clinkingGlasses} Brunch Dates',
      '${AppEmojis.cooking} Cooking at Home',
      '${AppEmojis.bubbleTea} Boba / Bubble Tea',
      '${AppEmojis.salad} Healthy Meal Prep',
      '${AppEmojis.doughnut} Donut Discoveries',
    ],
    'Music & Arts': [
      '${AppEmojis.musicalNotes} Indie Music',
      '${AppEmojis.guitar} Live Concerts',
      '${AppEmojis.art} Painting',
      '${AppEmojis.movieClapper} Movie Buff',
      '${AppEmojis.theaterMasks} Theater',
      '${AppEmojis.cameraFlash} Photography',
      '${AppEmojis.filmFrames} Film Editing',
      '${AppEmojis.musicalNotes} Music Production',
      '${AppEmojis.microphone} Podcasting',
      '${AppEmojis.art} Digital Art / Design',
      '${AppEmojis.saxophone} Jazz Music',
      '${AppEmojis.microphone} Karaoke',
      '${AppEmojis.violin} Classical Music',
    ],
    'Travel & Adventure': [
      '${AppEmojis.motorway} Road Trips',
      '${AppEmojis.backpack} Backpacking',
      '${AppEmojis.beachUmbrella} Beach Getaways',
      '${AppEmojis.cityscape} City Exploring',
      '${AppEmojis.hikingBoot} Sunrise Hikes',
      '${AppEmojis.camperVan} Van Life',
      '${AppEmojis.earthGlobe} Exploring New Cultures',
      '${AppEmojis.rollerCoaster} Theme Parks',
      '${AppEmojis.classicalBuilding} Historical Travel',
      '${AppEmojis.camping2} Weekend Escapes',
    ],
    'Tech & Gaming': [
      '${AppEmojis.joystick} Console Gaming',
      '${AppEmojis.desktopComputer} PC Gaming',
      '${AppEmojis.robot} AI & Innovation',
      '${AppEmojis.laptop} Coding / Dev Life',
      '${AppEmojis.building} Entrepreneurship',
      '${AppEmojis.wrench} Product Design',
      '${AppEmojis.headphone} Tech Podcasts',
      '${AppEmojis.brain} Learning New Tools',
      '${AppEmojis.chartUpwards} Crypto & Web3',
      '${AppEmojis.robot} Sci-Fi & Futurism',
      '${AppEmojis.chartIncreasing} Data Analytics',
      '${AppEmojis.globe} Cybersecurity',
    ],
    'Reading & Learning': [
      '${AppEmojis.openBook} Fiction',
      '${AppEmojis.psychology} Psychology',
      '${AppEmojis.historicalBuilding} History',
      '${AppEmojis.bookOpen} Self-Improvement',
      '${AppEmojis.dragon} Fantasy Novels',
      '${AppEmojis.microscope} Science & Discovery',
      '${AppEmojis.newspaper} Current Affairs',
      '${AppEmojis.writingHand} Journaling',
      '${AppEmojis.headphone} Audiobooks',
      '${AppEmojis.thoughtBalloon} Philosophy',
      '${AppEmojis.earthGlobe} Languages',
      '${AppEmojis.art} Art & Design',
      '${AppEmojis.television} Television & Film',
    ],
    'Other Fun Interests': [
      '${AppEmojis.dog} Dog Walks',
      '${AppEmojis.cat} Cat Cuddles',
      '${AppEmojis.personInLotus} Meditation',
      '${AppEmojis.label} Thrifting & Vintage Finds',
      '${AppEmojis.guitar} Music Jamming',
      '${AppEmojis.sunflower} Gardening',
      '${AppEmojis.bullseye} Trivia & Quizzes',
      '${AppEmojis.bicyclist} Cycling Adventures',
      '${AppEmojis.puzzlePiece} Puzzles',
      '${AppEmojis.house} Home Aesthetics',
      '${AppEmojis.openBook} Book Clubs',
      '${AppEmojis.womanDancing} Social Dancing',
    ],
  };

  // ========== COLLECTION VARIABLES ==========
  static final List<String> groupImages = [
    Assets.dummy.groupNight.path,
    Assets.dummy.groupFire.path,
    Assets.dummy.groupSunset.path,
    Assets.dummy.groupGlasses.path,
    Assets.dummy.groupSelfieBeach.path,
    Assets.dummy.groupSwiming.path,
  ];

  // Avatar paths matching the cover images
  static final List<String> avatarPaths = [
    Assets.dummy.a1.path,
    Assets.dummy.b1.path,
    Assets.dummy.c1.path,
    Assets.dummy.d1.path,
    Assets.dummy.e1.path,
  ];

  static final List<Map<String, dynamic>> switchGroups = [
    {
      'title': 'Brenda, Nancy, Jeff, Anna & You',
      'avatars': [
        Assets.dummy.a1.path,
        Assets.dummy.a2.path,
        Assets.dummy.a3.path,
        Assets.dummy.a4.path,
        Assets.dummy.a5.path,
      ],
    },
    {
      'title': 'Fiona, Hannah & You',
      'avatars': [
        Assets.dummy.b1.path,
        Assets.dummy.b2.path,
        Assets.dummy.b3.path,
      ],
    },
    {
      'title': 'Alex, Brianna, Daniel & You',
      'avatars': [
        Assets.dummy.c1.path,
        Assets.dummy.c2.path,
        Assets.dummy.c3.path,
        Assets.dummy.c4.path,
      ],
    },
    {
      'title': 'Natalie & You',
      'avatars': [Assets.dummy.d1.path, Assets.dummy.d2.path],
    },
  ];

  static final List<Group> groupsStatic = [
    Group(
      id: '1',
      name: 'Weekend Warriors',
      description:
          'A group for those who love to make the most of their weekends.',
      coverImage: Assets.dummy.groupNight.path,
      groupTag: '#WeekendVibes',
      photosVideos: [
        Assets.dummy.groupNight.path,
        Assets.dummy.groupSelfie.path,
      ],
      groupMembers: [
        GroupMember(
          id: 'gm1',
          name: 'Alex Johnson',
          image: Assets.dummy.a1.path,
        ),
        GroupMember(id: 'gm2', name: 'Sophia Lee', image: Assets.dummy.a2.path),
      ],
      groupPrompts: [
        GroupPrompt(
          id: 'gp1',
          promptTitle: 'What’s your perfect weekend?',
          promptAnswer: 'Spending time with friends and family.',
          type: 'text',
        ),
        GroupPrompt(
          id: 'gp2',
          promptTitle: 'Beach or mountains?',
          promptAnswer: 'Mountains for the fresh air and scenic views.',
          type: 'text',
        ),
      ],
      members: [
        Member(
          id: 'm1',
          firstName: 'Alex',
          name: 'Alex Johnson',
          age: 27,
          bio: 'Loves road trips, night drives, and good music.',
          coverImage: Assets.dummy.b1.path,
          gender: 'Male',
          orientation: 'Straight',
          pronouns: 'He/Him',
          education: 'Bachelors',
          profession: 'Software Engineer',
          interests: ['Travel', 'Music', 'Fitness'],
          images: [Assets.dummy.b2.path, Assets.dummy.b3.path],
          bestShorts: ['Adventurous', 'Energetic'],
          lifestyle: ['Gym', 'Non-smoker'],
        ),
        Member(
          id: 'm2',
          firstName: 'Sophia',
          name: 'Sophia Lee',
          age: 25,
          bio: 'Coffee lover and sunset chaser.',
          coverImage: Assets.dummy.c1.path,
          gender: 'Female',
          orientation: 'Straight',
          pronouns: 'She/Her',
          education: 'Masters',
          profession: 'UI/UX Designer',
          interests: ['Design', 'Photography', 'Travel'],
          images: [Assets.dummy.c2.path, Assets.dummy.c3.path],
          bestShorts: ['Creative', 'Chill'],
          lifestyle: ['Yoga', 'Vegan'],
        ),
      ],
    ),

    Group(
      id: '2',
      name: 'Fitness Freaks',
      description: 'For people who love staying fit and pushing limits.',
      coverImage: Assets.dummy.d1.path,
      groupTag: '#FitLife',
      photosVideos: [Assets.dummy.d2.path],
      groupMembers: [
        GroupMember(id: 'gm3', name: 'Ryan Smith', image: Assets.dummy.d3.path),
      ],
      groupPrompts: [
        GroupPrompt(
          id: 'gp3',
          promptTitle: 'What’s your go-to workout?',
          promptAnswer: 'I love a good HIIT session to get the heart pumping.',
          type: 'text',
        ),
        GroupPrompt(
          id: 'gp4',
          promptTitle: 'Morning or evening workouts?',
          promptAnswer: 'Morning workouts help me start the day energized.',
          type: 'text',
        ),
      ],
      members: [
        Member(
          id: 'm3',
          firstName: 'Ryan',
          name: 'Ryan Smith',
          age: 30,
          bio: 'Gym is my second home.',
          coverImage: Assets.dummy.d3.path,
          gender: 'Male',
          orientation: 'Straight',
          pronouns: 'He/Him',
          education: 'Diploma',
          profession: 'Personal Trainer',
          interests: ['Workout', 'Nutrition', 'Running'],
          images: [Assets.dummy.d3.path],
          bestShorts: ['Disciplined', 'Motivated'],
          lifestyle: ['Early riser', 'Non-smoker'],
        ),
      ],
    ),
  ];

  // group data
  static final List<Group> groups = [
    Group(
      id: '1',
      name: 'Weekend Warriors',
      coverImage: Assets.dummy.groupNight.path,
      groupTag: "#WeekendVibes",
      description:
          'A group for those who love to make the most of their weekends.',
    ),
    Group(
      id: '2',
      name: 'City Explorers',
      groupTag: "#CityLife",
      coverImage: Assets.dummy.groupFire.path,
      description:
          'Discover the hidden gems and vibrant life of the city together.',
      members: [
        Member(
          id: 'member_1',
          firstName: 'Brenda',
          name: 'Brenda',
          age: 28,
          coverImage: Assets.dummy.a1.path,
          bio: 'Love exploring new places',
          gender: 'Female',
          orientation: 'Straight',
          pronouns: 'She/Her',
          education: 'Bachelor\'s',
          profession: 'Designer',
          interests: [],
          images: [],
          lifestyle: [],
        ),
        Member(
          id: 'member_2',
          firstName: 'Jack',
          name: 'Jack',
          age: 30,
          coverImage: Assets.dummy.b1.path,
          bio: 'Adventure enthusiast',
          gender: 'Male',
          orientation: 'Straight',
          pronouns: 'He/Him',
          education: 'Bachelor\'s',
          profession: 'Engineer',
          interests: [],
          images: [],
          lifestyle: [],
        ),
        Member(
          id: 'member_3',
          firstName: 'Nancy',
          name: 'Nancy',
          age: 26,
          coverImage: Assets.dummy.a2.path,
          bio: 'Coffee lover and bookworm',
          gender: 'Female',
          orientation: 'Straight',
          pronouns: 'She/Her',
          education: 'Master\'s',
          profession: 'Writer',
          interests: [],
          images: [],
          lifestyle: [],
        ),
        Member(
          id: 'member_4',
          firstName: 'Jeff',
          name: 'Jeff',
          age: 32,
          coverImage: Assets.dummy.c1.path,
          bio: 'Fitness and nature',
          gender: 'Male',
          orientation: 'Straight',
          pronouns: 'He/Him',
          education: 'Bachelor\'s',
          profession: 'Personal Trainer',
          interests: [],
          images: [],
          lifestyle: [],
        ),
        Member(
          id: 'member_5',
          firstName: 'Anna',
          name: 'Anna',
          age: 27,
          coverImage: Assets.dummy.a3.path,
          bio: 'Travel blogger',
          gender: 'Female',
          orientation: 'Straight',
          pronouns: 'She/Her',
          education: 'Bachelor\'s',
          profession: 'Content Creator',
          interests: [],
          images: [],
          lifestyle: [],
        ),
        Member(
          id: 'member_6',
          firstName: 'John',
          name: 'John',
          age: 29,
          coverImage: Assets.dummy.d1.path,
          bio: 'Tech and gaming',
          gender: 'Male',
          orientation: 'Straight',
          pronouns: 'He/Him',
          education: 'Master\'s',
          profession: 'Developer',
          interests: [],
          images: [],
          lifestyle: [],
        ),
        Member(
          id: 'member_7',
          firstName: 'Alice',
          name: 'Alice',
          age: 25,
          coverImage: Assets.dummy.b2.path,
          bio: 'Art and music lover',
          gender: 'Female',
          orientation: 'Bisexual',
          pronouns: 'She/Her',
          education: 'Bachelor\'s',
          profession: 'Artist',
          interests: [],
          images: [],
          lifestyle: [],
        ),
        Member(
          id: 'member_8',
          firstName: 'Emma',
          name: 'Emma',
          age: 31,
          coverImage: Assets.dummy.c2.path,
          bio: 'Foodie and photographer',
          gender: 'Female',
          orientation: 'Straight',
          pronouns: 'She/Her',
          education: 'Bachelor\'s',
          profession: 'Photographer',
          interests: [],
          images: [],
          lifestyle: [],
        ),
        Member(
          id: 'member_9',
          firstName: 'James',
          name: 'James',
          age: 33,
          coverImage: Assets.dummy.e1.path,
          bio: 'Sports enthusiast',
          gender: 'Male',
          orientation: 'Straight',
          pronouns: 'He/Him',
          education: 'Bachelor\'s',
          profession: 'Coach',
          interests: [],
          images: [],
          lifestyle: [],
        ),
      ],
    ),
    Group(
      id: '3',
      name: 'Adventure Squad',
      groupTag: "#AdventureTime",
      coverImage: Assets.dummy.groupSunset.path,
      description: 'For the thrill-seekers and outdoor enthusiasts.',
    ),
    Group(
      id: '4',
      name: 'Foodie Friends',
      groupTag: "#Foodies",
      coverImage: Assets.dummy.groupGlasses.path,
      description:
          'Sharing a passion for delicious food and culinary adventures.',
    ),
    Group(
      id: '5',
      name: 'Tech Enthusiasts',
      groupTag: "#TechTalk",
      coverImage: Assets.dummy.groupSelfieBeach.path,
      description: 'Connecting over the latest in technology and innovation.',
    ),
    Group(
      id: '6',
      name: 'Creative Crew',
      groupTag: "#CreativeMinds",
      coverImage: Assets.dummy.groupSwiming.path,
      description:
          'A space for artists, writers, and creators to collaborate and inspire.',
    ),
  ];
  // List of predefined prompts
  static final List<String> predefinedPrompts = [
    'A perfect weekend for me looks like...',
    'The most spontaneous thing I\'ve done...',
    'My friends describe me as...',
    'Two truths and a lie...',
    'What I\'d bring to a group trip...',
    'The fastest way to make me smile...',
    'How my group describes me in one word...',
    'My ideal group activity is...',
  ];

  static List<ChatMessage> getMessages() {
    return [
      ChatMessage(
        id: 'msg_1',
        name: 'Jacob Hernandez',
        avatar: avatarPaths.isNotEmpty ? avatarPaths[0] : null,
        text:
            'Omg the dog\'s invited too?? We\'re 100% down ${AppEmojis.dogFaceEmoji}${AppEmojis.sparklingHeartEmoji}',
        type: 'text',
        isMe: false,
      ),
      ChatMessage(
        id: 'msg_2',
        name: 'Mark Young',
        avatar: avatarPaths.length > 1 ? avatarPaths[1] : null,
        text:
            'Hey hey 👋 just saw your group\'s profile — y\'all seem like fun! Any plans this weekend?',
        type: 'text',
        isMe: false,
        isMyGroup: true,
      ),
      ChatMessage(
        id: 'msg_3',
        name: 'Mark Young',
        avatar: avatarPaths.length > 1 ? avatarPaths[1] : null,
        text: 'We were actually talking about a beach day ☀️ — you guys in?',
        type: 'text',
        isMe: false,
        isMyGroup: true,
      ),
      ChatMessage(
        id: 'msg_4',
        name: 'Raymond Hernandez',
        avatar: avatarPaths.length > 2 ? avatarPaths[2] : null,
        text: 'We\'re definitely in the mood already 😎',
        type: 'text',
        isMe: false,
      ),
      ChatMessage(
        id: 'msg_5',
        name: 'Raymond Hernandez',
        avatar: avatarPaths.length > 2 ? avatarPaths[2] : null,
        type: 'image',
        images: [
          'https://images.unsplash.com/photo-1529156069898-49953e39b3ac?w=800',
          'https://images.unsplash.com/photo-1523413363574-c30aa1c2a516?w=800',
          'https://images.unsplash.com/photo-1530789253388-582c481c54b0?w=800',
          'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800',
        ],
        isMe: false,
      ),
      ChatMessage(
        id: 'msg_6',
        name: 'Prime Chat',
        avatar: avatarPaths.length > 3 ? avatarPaths[3] : null,
        text:
            'This is the vibe I\'m talking about ${AppEmojis.fire}${AppEmojis.fire}',
        type: 'text',
        isMe: false,
      ),
      ChatMessage(
        id: 'msg_7',
        name: 'Robert Rodriguez',
        avatar: avatarPaths.length > 4 ? avatarPaths[4] : null,
        type: 'image',
        images: [
          'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=800',
        ],
        isMe: false,
      ),
      ChatMessage(
        id: 'msg_8',
        name: 'Jonathan Hernandez',
        avatar: avatarPaths.length > 1 ? avatarPaths[1] : null,
        text: 'Let\'s meet at Driftwood Cove — 1 PM works?',
        type: 'text',
        isMe: false,
        isMyGroup: true,
      ),
      ChatMessage(
        id: 'msg_9',
        name: 'Lisa Hernandez',
        avatar: avatarPaths.length > 2 ? avatarPaths[2] : null,
        type: 'voice',
        duration: '00:16',
        isMe: false,
      ),
      ChatMessage(
        id: 'msg_10',
        name: 'Melissa Lee',
        avatar: avatarPaths.length > 3 ? avatarPaths[3] : null,
        type: 'voice',
        duration: '00:16',
        isMe: false,
      ),
      ChatMessage(
        id: 'msg_11',
        name: 'Amanda Rodriquez',
        avatar: avatarPaths.length > 4 ? avatarPaths[4] : null,
        text: 'Absolutely! @Melissa Lee',
        mentionedUser: '@Melissa Lee',
        type: 'text',
        isMe: false,
        isMyGroup: true,
        reactions: {
          AppEmojis.thumbsUpEmoji: ['2', '3', '4', '5'],
          AppEmojis.faceWithTearsOfJoyEmoji: ['3', '6', '7'],
          AppEmojis.redHeartEmoji: ['1', '2'],
        },
      ),
      ChatMessage(
        id: 'msg_12',
        name: 'Amanda Rodriquez',
        avatar: avatarPaths.length > 4 ? avatarPaths[4] : null,
        text:
            'I can\'t wait to see everyone and bring some treats for the pups! ${AppEmojis.smilingFaceWithHeart}${AppEmojis.dog}',
        type: 'text',
        isMe: false,
        isMyGroup: true,
      ),
      ChatMessage(
        id: 'msg_13',
        name: 'Me',
        text:
            'Sounds perfect! I\'ll bring some frisbees for the dogs to play with.',
        type: 'text',
        isMe: true,
      ),
      ChatMessage(
        id: 'msg_14',
        name: 'Gary Jones',
        avatar: avatarPaths.length > 5 ? avatarPaths[5] : null,
        text: 'Count me in! I\'ll bring some snacks and drinks for us.',
        type: 'text',
        isMe: false,
      ),
    ];
  }

  static final List<ChatRoom> chats = [
    ChatRoom(
      id: '698649505f012b8bcb5cac1f',
      name: 'Anna Taylor',
      message: 'I\'m in! Let\'s plan for a fun evening together.',
      timeAgo: '5m ago',
      isGroup: false,
      avatar: avatarPaths.isNotEmpty ? avatarPaths[0] : null,
      isOnline: true,
    ),
    ChatRoom(
      id: '698649505f012b8bcb5cac1f',
      names: ['Brenda', 'Jack', 'Nancy', 'Jeff', 'Anna'],
      message: 'Count me in! I\'ll bring some snacks and drinks for...',
      timeAgo: '2h ago',
      isGroup: true,
      avatars: avatarPaths,
    ),
    ChatRoom(
      id: '698649505f012b8bcb5cac1f',
      name: 'Brenda Taylor',
      message: 'I can make a salad! Just tell me what you need.',
      timeAgo: '15m ago',
      isGroup: false,
      avatar: avatarPaths.length > 1 ? avatarPaths[1] : null,
      isOnline: false,
    ),
    ChatRoom(
      id: '698649505f012b8bcb5cac1f',
      name: 'Nancy Garcia',
      message: 'I\'ll bring the drinks! What do you all prefer?',
      timeAgo: '10m ago',
      isGroup: false,
      avatar: avatarPaths.length > 2 ? avatarPaths[2] : null,
      isOnline: true,
    ),
    ChatRoom(
      id: '698649505f012b8bcb5cac1f',
      name: 'James Richard',
      message: 'You Got a Poke!',
      timeAgo: '5m ago',
      isGroup: false,
      avatar: avatarPaths.length > 3 ? avatarPaths[3] : null,
      isOnline: false,
    ),
    ChatRoom(
      id: '698649505f012b8bcb5cac1f',
      names: ['Brenda', 'Jack', 'Nancy', 'Jeff', 'Anna'],
      message: 'Count me in! I\'ll bring some snacks and drinks for...',
      timeAgo: '2h ago',
      isGroup: true,
      avatars: avatarPaths,
    ),
    ChatRoom(
      id: '698649505f012b8bcb5cac1f',
      name: 'Brenda Taylor',
      message: 'I can make a salad! Just tell me what you need.',
      timeAgo: '15m ago',
      isGroup: false,
      avatar: avatarPaths.length > 1 ? avatarPaths[1] : null,
      isOnline: true,
      isPoked: true,
    ),
  ];

  static List<Map<String, dynamic>> groupsChat = [
    {
      'id': 1,
      'names': ['Brenda', 'Jack', 'Nancy', 'Jeff', 'Anna'],
      'lastMessage': 'Count me in! I\'ll bring some snacks and drinks for...',
      'time': '2h ago',
      'avatars': [
        Assets.dummy.a1.path,
        Assets.dummy.a2.path,
        Assets.dummy.a3.path,
        Assets.dummy.a4.path,
        Assets.dummy.a5.path,
      ],
    },
  ];

  // Mock data for call history
  static List<Map<String, dynamic>> callHistory = [
    {
      'id': 1,
      'name': 'Nancy Garcia',
      'callType': 'Voice Call',
      'duration': '12m 5s',
      'timeAgo': '8m ago',
      'avatar': Assets.dummy.b1.path,
      'isGroup': false,
    },
    {
      'id': 2,
      'name': 'Brenda Taylor',
      'callType': 'Voice Call',
      'duration': '12m 5s',
      'timeAgo': '5d ago',
      'avatar': Assets.dummy.b2.path,
      'isGroup': false,
    },
    {
      'id': 3,
      'name': 'Anna Taylor',
      'callType': 'Voice Call',
      'duration': '12m 5s',
      'timeAgo': '16m ago',
      'avatar': Assets.dummy.b3.path,
      'isGroup': false,
    },
    {
      'id': 4,
      'names': ['Brenda', 'Jack', 'Nancy', 'Jeff', 'Anna'],
      'callType': 'Voice Call',
      'duration': '12m 5s',
      'timeAgo': '5m ago',
      'avatars': [
        Assets.dummy.c1.path,
        Assets.dummy.c2.path,
        Assets.dummy.c3.path,
        Assets.dummy.c4.path,
        Assets.dummy.c5.path,
      ],
      'isGroup': true,
    },
    {
      'id': 5,
      'name': 'Anna Taylor',
      'callType': 'Voice Call',
      'duration': '12m 5s',
      'timeAgo': '2d ago',
      'avatar': Assets.dummy.d1.path,
      'isGroup': false,
    },
    {
      'id': 6,
      'name': 'Nancy Garcia',
      'callType': 'Video Call',
      'duration': '12m 5s',
      'timeAgo': '22d ago',
      'avatar': Assets.dummy.d2.path,
      'isGroup': false,
    },
    {
      'id': 7,
      'name': 'Brenda Taylor',
      'callType': 'Voice Call',
      'duration': '12m 5s',
      'timeAgo': '21w ago',
      'avatar': Assets.dummy.d3.path,
      'isGroup': false,
    },
    {
      'id': 8,
      'names': ['Brenda', 'Jack', 'Nancy', 'Jeff', 'Anna'],
      'callType': 'Video Call',
      'duration': '12m 5s',
      'timeAgo': '17m ago',
      'avatars': [
        Assets.dummy.e1.path,
        Assets.dummy.e2.path,
        Assets.dummy.e3.path,
        Assets.dummy.e4.path,
        Assets.dummy.e5.path,
      ],
      'isGroup': true,
    },
    {
      'id': 9,
      'name': 'Anna Taylor',
      'callType': 'Voice Call',
      'duration': '12m 5s',
      'timeAgo': '12d ago',
      'avatar': Assets.dummy.b3.path,
      'isGroup': false,
    },
    {
      'id': 10,
      'name': 'Nancy Garcia',
      'callType': 'Voice Call',
      'duration': '12m 5s',
      'timeAgo': '21m ago',
      'avatar': Assets.dummy.b1.path,
      'isGroup': false,
    },
    {
      'id': 11,
      'name': 'Brenda Taylor',
      'callType': 'Voice Call',
      'duration': '12m 5s',
      'timeAgo': '1w ago',
      'avatar': Assets.dummy.b2.path,
      'isGroup': false,
    },
    {
      'id': 12,
      'names': ['Brenda', 'Jack', 'Nancy', 'Jeff', 'Anna'],
      'callType': 'Video Call',
      'duration': '12m 5s',
      'timeAgo': '13w ago',
      'avatars': [
        Assets.dummy.c1.path,
        Assets.dummy.c2.path,
        Assets.dummy.c3.path,
        Assets.dummy.c4.path,
        Assets.dummy.c5.path,
      ],
      'isGroup': true,
    },
  ];
  static final List<String> groupMembers = [
    'Brenda',
    'Jack',
    'Nancy',
    'Jeff',
    'Anna',
    'John',
    'Alice',
    'You',
    'Emma',
    'James',
  ];

  static final List<String> interests = [
    '🎵 Music Festivals',
    '🍔 Street Food Explorer',
    '📸 Photography',
    '🔥 Weekend Escapes',
    '🎨 Art & Design',
  ];

  static final List<PokePack> pokePacks = [
    PokePack(
      pokes: 3,
      title: 'Starter Pack',
      subtitle: 'Perfect for trying it out.',
      price: '\$5.99',
    ),
    PokePack(
      pokes: 3,
      title: 'Starter Pack',
      subtitle: 'Perfect for trying it out.',
      price: '\$5.99',
    ),
    PokePack(
      pokes: 50,
      title: 'Premium Pack',
      subtitle: 'Perfect for trying it out.',
      price: '\$7.99',
    ),
  ];
  static final notificationItems = [
    NotificationTileData(
      title: 'Group Matches',
      subtitle: 'Get notified when your group matches with another group.',
      value: false,
    ),
    NotificationTileData(
      title: 'New Messages',
      subtitle: 'Alerts for incoming messages and media in your chats.',
      value: false,
    ),
    NotificationTileData(
      title: 'Calls & Missed Calls',
      subtitle:
          'Receive notifications for incoming and missed voice or video calls.',
      value: false,
    ),
    NotificationTileData(
      title: 'Message Reactions',
      subtitle: 'Stay updated when someone reacts to your messages.',
      value: false,
    ),
    NotificationTileData(
      title: 'Mentions & Replies',
      subtitle:
          'Be notified when someone tags or replies to you in group chats.',
      value: false,
    ),
    NotificationTileData(
      title: 'Group Invites & Requests',
      subtitle: 'Alerts for new group invitations and join requests.',
      value: false,
    ),
    NotificationTileData(
      title: 'App Announcements',
      subtitle:
          'Important updates, new features, and system messages from Fennec.',
      value: false,
    ),
    NotificationTileData(
      title: 'Email Notifications',
      subtitle: 'Receive summaries and important alerts via email.',
      value: false,
    ),
  ];

  static const List<NotificationTileData> privacyItems = [
    NotificationTileData(
      title: 'Activity Status',
      subtitle: 'Allow others to see your activity status.',
      value: true,
    ),
    NotificationTileData(
      title: 'Location Sharing',
      subtitle: 'Allow location access.',
      value: true,
    ),
    NotificationTileData(
      title: 'Contact Access',
      subtitle: 'Allow access to contacts.',
      value: true,
    ),
    NotificationTileData(
      title: 'Media Permissions',
      subtitle: 'Allow access to media files.',
      value: true,
    ),
  ];
  static final List<String> interestsGroup = [
    '${AppEmojis.guitar} Music Festivals',
    '${AppEmojis.hamburger} Street Food Explorer',
    '${AppEmojis.camera} Photography',
    '${AppEmojis.camping} Weekend Escapes',
    '${AppEmojis.artistPalette} Art & Design',
  ];

  // Dummy media items (mix of images and videos)
  static final List<Map<String, dynamic>> mediaItems = [
    {'type': 'video', 'image': Assets.dummy.groupNight.path},
    {'type': 'video', 'image': Assets.dummy.groupFire.path},
    {'type': 'image', 'image': Assets.dummy.groupSelfieBeach.path},
    {'type': 'video', 'image': Assets.dummy.groupSunset.path},
    {'type': 'video', 'image': Assets.dummy.groupSwiming.path},
    {'type': 'video', 'image': Assets.dummy.groupGlasses.path},
    {'type': 'video', 'image': Assets.dummy.groupSelfie.path},
    {'type': 'image', 'image': Assets.dummy.portrait.path},
    {'type': 'image', 'image': Assets.dummy.girlCar.path},
  ];
  static final List<FaqItem> faqItems = [
    FaqItem(
      question: 'Is there a limit to the number of groups I can join?',
      answer:
          'There is no specific limit. You can join and manage multiple groups based on your interests and social needs.',
    ),
    FaqItem(
      question: 'How can I report inappropriate behavior in a group?',
      answer:
          'You can report a user by visiting their profile and selecting the report option. Our moderation team will review it within 24 hours.',
    ),
    FaqItem(
      question: 'Can I leave a group at any time?',
      answer:
          'Yes, you can leave any group at any time from the group settings. Your data and matches will be cleared upon leaving.',
    ),
    FaqItem(
      question: 'What are the benefits of joining a group?',
      answer:
          'Groups allow you to connect with like-minded people, participate in group activities, and find potential matches within your community.',
    ),
    FaqItem(
      question: 'How do I find groups that match my interests?',
      answer:
          'Use our discovery feature to browse groups by category, location, and interests. You can also search for specific groups or use trending tags.',
    ),
    FaqItem(
      question: 'Can I block other users?',
      answer:
          'Yes, you can block users by visiting their profile and selecting the block option. Blocked users won\'t be able to contact or see you.',
    ),
    FaqItem(
      question: 'Are there any fees associated with group memberships?',
      answer:
          'Most groups are free to join. Some exclusive groups may have membership fees which will be clearly indicated before joining.',
    ),
    FaqItem(
      question: 'What privacy settings are available for my profile?',
      answer:
          'You can control who sees your profile, limit visibility to group members only, or make it completely private in your privacy settings.',
    ),
    FaqItem(
      question: 'Can I view my group\'s activity history?',
      answer:
          'Yes, group members can view the activity history of the group, including member joins, messages, and other important events.',
    ),
    FaqItem(
      question: 'What should I do if I encounter technical issues?',
      answer:
          'Contact our support team through the help section in settings. We typically respond within 24-48 hours with solutions to common issues.',
    ),
  ];
}
