

import 'package:flutter/material.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({Key? key}) : super(key: key);

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  // Sample FAQ categories
  final List<String> faqCategories = [
    'About Us',
    'Events',
    'Recycling',
    'Rewards',
    'Privacy'
  ];

  // Enhanced FAQ data for each category
  final Map<String, List<Map<String, String>>> faqData = {
  'About Us': [
  {
  'question': 'What is Eco-Connect and how does it work?',
  'answer': 'Eco-Connect is a platform that connects environmentally conscious individuals with waste management initiatives and sustainable practices. Our app provides information about local events, educational resources, and ways to participate in community clean-up activities.'
  },
  {
  'question': 'Does Eco-Connect operate internationally?',
  'answer': 'Currently, we operate in select cities in India. We are gradually expanding to more locations. Stay tuned for updates about availability in your area.'
  },
  {
  'question': 'Who founded Eco-Connect and when?',
  'answer': 'Eco-Connect was founded in 2021 by a group of environmental scientists and tech enthusiasts who wanted to create a practical solution for community-based environmental action. Our team brings together expertise in waste management, environmental science, and technology development.'
  },
  {
  'question': 'What is Eco-Connect\'s mission?',
  'answer': 'Our mission is to empower communities to take meaningful environmental action through accessible technology, education, and collaborative initiatives. We aim to reduce waste, promote sustainable practices, and create measurable positive impact on local ecosystems.'
  },
  {
  'question': 'How can I contact the Eco-Connect team?',
  'answer': 'You can reach our support team through the Contact Us section in the app, by emailing support@eco-connect.com, or by calling our helpline at +91-1234567890 during business hours (Mon-Fri, 9am-5pm IST).'
  }
  ],
  'Events': [
  {
  'question': 'How can I participate in local clean-up events?',
  'answer': 'You can browse upcoming events in the Events tab, register for them through the app, and receive notifications before the event. We also provide information about what to bring and how to prepare.'
  },
  {
  'question': 'Can I create my own eco-friendly events?',
  'answer': 'Yes! Just use the + button at the bottom left of the app to create and submit your own eco-friendly event proposals. Our team will review and approve appropriate events.'
  },
  {
  'question': 'How often are clean-up events organized?',
  'answer': 'Event frequency varies by location. In most active cities, we organize at least 2-3 community events monthly. During special environmental campaigns or seasons, the frequency may increase. You can set your location preferences to see the event calendar for your area.'
  },
  {
  'question': 'What should I bring to a clean-up event?',
  'answer': 'We recommend bringing: reusable gloves, a water bottle, sun protection (hat/sunscreen), comfortable clothing suitable for weather conditions, and a small backpack. Eco-Connect provides collection bags, basic tools, and safety equipment at most events.'
  },
  {
  'question': 'Can I bring children to Eco-Connect events?',
  'answer': 'Yes, most events are family-friendly. Events suitable for children are clearly marked with a "Family Friendly" tag. For safety reasons, children under 14 must be accompanied by an adult. Some specialized events (like industrial area clean-ups) may have age restrictions.'
  },
  {
  'question': 'What happens if an event is cancelled due to weather?',
  'answer': 'If an event needs to be cancelled due to inclement weather or unforeseen circumstances, you\'ll receive a notification through the app at least 2 hours before the scheduled start time. Most cancelled events are rescheduled within 2 weeks.'
  }
  ],
  'Recycling': [
  {
  'question': 'What types of waste can I recycle through Eco-Connect?',
  'answer': 'Eco-Connect helps you recycle paper, plastic, glass, metal, e-waste, and organic waste. Our app provides guidelines for proper segregation and information about local recycling centers.'
  },
  {
  'question': 'How does Eco-Connect verify waste collection data?',
  'answer': 'We use a combination of user photos, location data, and community verification to ensure accuracy of waste collection data. Our moderators also review submissions regularly.'
  },
  {
  'question': 'Where can I find recycling centers near me?',
  'answer': 'The app features an interactive map where you can locate nearby recycling centers, collection points, and drop-off locations. You can filter by the type of materials accepted and operating hours. The map also shows user ratings and reviews of each location.'
  },
  {
  'question': 'What happens to the waste after collection?',
  'answer': 'Collected waste is transported to certified recycling facilities partnered with Eco-Connect. Different materials follow different recycling processes - plastics are cleaned, sorted by type, and processed into pellets; paper is pulped and reformed; glass is crushed and melted; and e-waste is carefully disassembled for component recovery.'
  },
      {
  'question': 'How does recycling through Eco-Connect benefit the environment?',
  'answer': 'For every kilogram of waste recycled through our platform, we track environmental impact metrics: carbon emissions reduced, water saved, energy conserved, and landfill space preserved. In 2024 alone, our community\'s recycling efforts have prevented over 50,000 kg of CO2 emissions and saved approximately 2 million liters of water.'
},
{
'question': 'Can I recycle items that aren not listed in the app?',
'answer': 'If you have items not specifically listed in our guidelines, use the "Ask about Recycling" feature to send us a photo. Our waste management experts will respond within 24 hours with appropriate disposal instructions for your location.'
}
],
'Rewards': [
{
'question': 'How do I earn eco-points on the app?',
'answer': 'You earn eco-points by participating in events, correctly answering quizzes, referring friends, and logging your personal waste management activities. These points can be redeemed for eco-friendly products or discounts from our partner organizations.'
},
{
'question': 'Can businesses partner with Eco-Connect?',
'answer': 'Yes, businesses can partner with us to promote their sustainable initiatives, sponsor events, or offer rewards for our eco-points program. Please contact us through the app for partnership opportunities.'
},
{
'question': 'How long do eco-points last before expiring?',
'answer': 'Eco-points are valid for 12 months from the date they are earned. The app provides a clear breakdown of your points balance including how many points are expiring each month, allowing you to plan your redemptions accordingly.'
},
{
'question': 'What kinds of rewards can I redeem my points for?',
'answer': 'Rewards include discounts at eco-friendly stores, free products (reusable straws, cloth bags, water bottles), subscription boxes, plant saplings, and donations to environmental causes. Premium rewards include eco-tourism experiences and sustainable fashion items.'
},
{
'question': 'Is there a leaderboard for eco-points?',
'answer': 'Yes, the app features monthly, seasonal, and all-time leaderboards at both local and national levels. Top performers receive special badges, limited-edition rewards, and opportunities to be featured in our community spotlights and social media.'
},
{
'question': 'Can I transfer my eco-points to someone else?',
'answer': 'Yes, you can gift or transfer points to other Eco-Connect users through the "Gift Points" feature in the rewards section. This is especially useful for team or family participation where you might want to pool points together for premium rewards.'
}
],
'Privacy': [
{
'question': 'Is my personal data secure on Eco-Connect?',
'answer': 'Yes, we take data privacy seriously. We only collect information necessary for the functioning of the app and do not share your personal data with third parties without your consent. Please refer to our privacy policy for more details.'
},
{
'question': 'How can I suggest new features for the app?',
'answer': 'We welcome user feedback! You can send feature suggestions through the feedback form in the profile section or email us directly at support@eco-connect.com.'
},
{
'question': 'Can I delete my account and all associated data?',
'answer': 'Yes, you can request account deletion through the Privacy & Security section in your profile settings. Once confirmed, we permanently delete your personal information, activity history, and content contributions within 30 days, in accordance with data protection regulations.'
},
{
'question': 'Does Eco-Connect track my location?',
'answer': 'Location data is only collected when you actively use location-based features like finding nearby recycling centers or checking in at events. You can control location permissions in your device settings and within the app\'s privacy preferences. We never track your location in the background.'
},
{
'question': 'How can I update my personal information?',
'answer': 'You can update your profile information including name, email, phone number, and preferences in the Profile section. For critical changes like your primary email address, we send a verification link to both your old and new email addresses to confirm the change.'
},
{
'question': 'How long does Eco-Connect retain my activity data?',
'answer': 'We retain your activity data (event participation, recycling logs, etc.) for 24 months to provide you with historical impact reports and continuous service. Data older than 24 months is anonymized and aggregated for statistical analysis only. You can request earlier deletion through privacy settings.'
}
]
};

String _selectedCategory = 'About Us';

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('FAQ', style: TextStyle(color: Colors.white)),
      backgroundColor: const Color(0xFF4D8B55),
      iconTheme: const IconThemeData(color: Colors.white),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
    ),
    body: Column(
      children: [
        // Category Selection Horizontal List
        Container(
          height: 60,
          color: const Color(0xFFD0E8D0),
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: faqCategories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ChoiceChip(
                  label: Text(faqCategories[index]),
                  selected: _selectedCategory == faqCategories[index],
                  onSelected: (bool selected) {
                    setState(() {
                      _selectedCategory = faqCategories[index];
                    });
                  },
                  selectedColor: const Color(0xFF4D8B55),
                  backgroundColor: Colors.white,
                  labelStyle: TextStyle(
                    color: _selectedCategory == faqCategories[index]
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(color: Color(0xFF4D8B55)),
                  ),
                ),
              );
            },
          ),
        ),

        // FAQ List for Selected Category
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: faqData[_selectedCategory]!.length,
            itemBuilder: (context, index) {
              final faq = faqData[_selectedCategory]![index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ExpansionTile(
                  title: Text(
                    faq['question']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4D8B55),
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        faq['answer']!,
                        style: const TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
}
