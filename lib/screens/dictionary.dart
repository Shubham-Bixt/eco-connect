import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'home_screen.dart';
import 'past_event.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eco Connect',
      theme: ThemeData(
        primaryColor: const Color(0xFF4D8D6E),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const WasteDictionary(),
    );
  }
}

class WasteDictionary extends StatefulWidget {
  const WasteDictionary({super.key});

  @override
  _WasteDictionaryState createState() => _WasteDictionaryState();
}

class _WasteDictionaryState extends State<WasteDictionary> {
  int _selectedIndex = 1; // Dictionary tab selected by default
  String searchQuery = '';
  List<WasteItem> filteredItems = [];

  final List<WasteItem> wasteItems = [
    WasteItem(
        name: 'Plastic Bottle',
        icon: 'assets/images/plastic_bottle.png',
        category: 'Plastic',
        isRecyclable: true,
        isOrganic: false,
        details: {
          'Types of plastic bottle': [
            'PET: a type of plastic that may be used to carry water and beverages on the go',
            'PE: a soft plastic bottle material that is also used to make detergent bottles',
            'PVC: a polymer that is used to make pharmaceutical bottles (oils)',
            'PC: a material that is used to create durable and reusable bottles',
            'PVC: a durable material used for products that require long-term storage',
          ]
        }
    ),
    WasteItem(
        name: 'Glass Bottle',
        icon: 'assets/images/glass_bottle.png',
        category: 'Glass',
        isRecyclable: true,
        isOrganic: false,
        details: {
          'Glass recycling facts': [
            'Glass can be recycled indefinitely without quality degradation',
            'Should be separated by color (clear, green, brown) for optimal recycling',
            'Requires cleaning before recycling to remove contaminants',
            'Recycling one glass bottle saves enough energy to light a 100-watt bulb for four hours',
            'Glass takes approximately 1 million years to decompose naturally'
          ]
        }
    ),
    WasteItem(
        name: 'Aluminum Can',
        icon: 'assets/images/aluminum_can.png',
        category: 'Metal',
        isRecyclable: true,
        isOrganic: false,
        details: {
          'Recycling benefits': [
            'Recycling aluminum uses 95% less energy than producing new aluminum',
            'Can be recycled indefinitely without quality loss',
            'Should be rinsed and crushed before recycling',
            'Takes 200-500 years to decompose in landfills',
            'One of the most valuable recyclable materials'
          ]
        }
    ),
    WasteItem(
        name: 'Paper',
        icon: 'assets/images/paper.png',
        category: 'Paper',
        isRecyclable: true,
        isOrganic: true,
        details: {
          'Types of recyclable paper': [
            'Newspapers and magazines',
            'Office paper and envelopes',
            'Cardboard and paperboard',
            'Paper bags and wrapping paper',
            'Books and phone directories'
          ],
          'Non-recyclable paper': [
            'Tissues and paper towels',
            'Waxed or laminated paper',
            'Paper contaminated with food',
            'Thermal receipt paper'
          ]
        }
    ),
    WasteItem(
        name: 'Food Waste',
        icon: 'assets/images/food_waste.png',
        category: 'Organic',
        isRecyclable: false,
        isOrganic: true,
        details: {
          'Disposal options': [
            'Composting: converts food waste into nutrient-rich soil',
            'Anaerobic digestion: produces biogas and fertilizer',
            'Animal feed: certain food waste can be repurposed',
            'Landfill: least preferred option as it produces methane',
            'Home composting: reduces waste collection needs'
          ]
        }
    ),
    WasteItem(
        name: 'Electronic Waste',
        icon: 'assets/images/electronic_waste.png',
        category: 'E-waste',
        isRecyclable: true,
        isOrganic: false,
        details: {
          'Common e-waste items': [
            'Computers and laptops',
            'Smartphones and tablets',
            'Televisions and monitors',
            'Printers and scanners',
            'Small household appliances'
          ],
          'Hazardous components': [
            'Contains lead, mercury, cadmium and other toxic materials',
            'Requires specialized recycling to prevent environmental contamination',
            'Many components can be recovered and reused'
          ]
        }
    ),
    WasteItem(
        name: 'Batteries',
        icon: 'assets/images/batteries.png',
        category: 'Hazardous',
        isRecyclable: true,
        isOrganic: false,
        details: {
          'Battery types': [
            'Alkaline batteries (common household)',
            'Lithium-ion batteries (rechargeable)',
            'Lead-acid batteries (automotive)',
            'Button cell batteries (watches, hearing aids)',
            'Nickel-cadmium batteries (older rechargeable)'
          ],
          'Disposal information': [
            'Should never be placed in regular trash',
            'Contains hazardous materials that can leach into soil and water',
            'Many retailers offer battery recycling collection points',
            'Some municipalities offer special collection events'
          ]
        }
    ),
    WasteItem(
        name: 'Textiles',
        icon: 'assets/images/textiles.png',
        category: 'Fabric',
        isRecyclable: true,
        isOrganic: false,
        details: {
          'Textile waste options': [
            'Donation: reusable clothing can be donated to charities',
            'Textile recycling: worn-out fabrics can be repurposed into insulation or rags',
            'Upcycling: creative reuse of old textiles into new products',
            'Composting: natural fibers like cotton and wool are biodegradable',
            'Some synthetic fibers can be recycled into new polyester products'
          ]
        }
    ),
    WasteItem(
        name: 'Plastic Bag',
        icon: 'assets/images/plastic_bag.png',
        category: 'Plastic',
        isRecyclable: true,
        isOrganic: false,
        details: {
          'Environmental impact': [
            'Takes 10-1000 years to decompose depending on type',
            'Often becomes microplastic pollution in oceans',
            'Harmful to marine life and wildlife',
            'Should be returned to grocery store collection points for recycling',
            'Not typically accepted in curbside recycling programs'
          ]
        }
    ),
    WasteItem(
        name: 'Green Waste',
        icon: 'assets/images/green_waste.png',
        category: 'Organic',
        isRecyclable: true,
        isOrganic: true,
        details: {
          'Green waste components': [
            'Grass clippings and leaves',
            'Tree and shrub trimmings',
            'Branches and twigs',
            'Plants and flowers',
            'Weeds (non-invasive)'
          ],
          'Benefits of composting': [
            'Reduces methane emissions from landfills',
            'Creates nutrient-rich soil amendment',
            'Reduces need for chemical fertilizers',
            'Conserves water by improving soil structure'
          ]
        }
    ),
    WasteItem(
        name: 'Medical Waste',
        icon: 'assets/images/medical_waste.png',
        category: 'Hazardous',
        isRecyclable: false,
        isOrganic: false,
        details: {
          'Types of medical waste': [
            'Sharps waste: needles, syringes, lancets',
            'Infectious waste: materials contaminated with blood or bodily fluids',
            'Pharmaceutical waste: expired or unused medications',
            'Pathological waste: human tissues or body parts',
            'Chemotherapy waste: materials used in cancer treatment'
          ],
          'Disposal requirements': [
            'Requires specialized handling and disposal',
            'Never place in regular trash or recycling',
            'Many pharmacies accept sharps containers and unused medications',
            'Should be properly contained in designated containers'
          ]
        }
    ),
    WasteItem(
        name: 'Construction Debris',
        icon: 'assets/images/construction_debris.png',
        category: 'C&D Waste',
        isRecyclable: true,
        isOrganic: false,
        details: {
          'Common materials': [
            'Concrete and masonry',
            'Wood and lumber',
            'Drywall and plaster',
            'Metals and wiring',
            'Roofing materials'
          ],
          'Recycling potential': [
            'Concrete can be crushed and reused as aggregate',
            'Wood can be chipped for mulch or burned for energy',
            'Metals have high recycling value',
            'Many materials can be salvaged for reuse in new projects',
            'Specialized C&D recycling facilities exist in many areas'
          ]
        }
    ),
    WasteItem(
        name: 'Coffee Grounds',
        icon: 'assets/images/coffee_grounds.png',
        category: 'Organic',
        isRecyclable: true,
        isOrganic: true,
        details: {
          'Reuse options': [
            'Excellent addition to compost piles',
            'Can be used as natural fertilizer for acid-loving plants',
            'Works as a natural pest repellent in gardens',
            'Can absorb odors in refrigerators',
            'Used in DIY beauty products and scrubs'
          ]
        }
    ),
    WasteItem(
        name: 'Light Bulbs',
        icon: 'assets/images/light_bulbs.png',
        category: 'Hazardous',
        isRecyclable: true,
        isOrganic: false,
        details: {
          'Types and disposal': [
            'Incandescent bulbs: generally not recyclable, dispose in regular trash',
            'CFL bulbs: contain mercury, must be recycled properly',
            'LED bulbs: electronic components should be recycled',
            'Fluorescent tubes: contain mercury, require special handling',
            'Halogen bulbs: can be disposed in regular trash'
          ]
        }
    ),
    WasteItem(
        name: 'Cooking Oil',
        icon: 'assets/images/cooking_oil.png',
        category: 'Liquid Waste',
        isRecyclable: true,
        isOrganic: true,
        details: {
          'Disposal methods': [
            'Never pour down drains as it causes clogs and water pollution',
            'Can be recycled into biodiesel',
            'Many municipalities have cooking oil collection points',
            'Small amounts can be solidified and placed in trash',
            'Some restaurants accept used cooking oil for recycling'
          ]
        }
    ),
    WasteItem(
        name: 'Metal Scrap',
        icon: 'assets/images/metal_scrap.png',
        category: 'Metal',
        isRecyclable: true,
        isOrganic: false,
        details: {
          'Common recyclable metals': [
            'Steel and iron',
            'Aluminum',
            'Copper',
            'Brass',
            'Stainless steel'
          ],
          'Recycling benefits': [
            'Conserves natural resources',
            'Reduces energy consumption compared to mining raw materials',
            'Prevents metal contaminants from entering landfills',
            'Often has monetary value at scrap yards',
            'Can be recycled indefinitely without loss of quality'
          ]
        }
    ),
    WasteItem(
        name: 'Styrofoam',
        icon: 'assets/images/styrofoam.png',
        category: 'Plastic',
        isRecyclable: false,
        isOrganic: false,
        details: {
          'Disposal challenges': [
            'Not accepted in most curbside recycling programs',
            'Takes hundreds of years to decompose',
            'Breaks into small pieces that pollute environment',
            'Some specialized facilities can recycle clean styrofoam',
            'Consider alternatives like paper or biodegradable packaging'
          ]
        }
    ),
    WasteItem(
        name: 'Pharmaceutical Waste',
        icon: 'assets/images/pharmaceutical_waste.png',
        category: 'Hazardous',
        isRecyclable: false,
        isOrganic: false,
        details: {
          'Proper disposal': [
            'Never flush medications down toilet or drain',
            'Many pharmacies offer take-back programs',
            'DEA hosts periodic National Prescription Drug Take-Back Days',
            'Some medications can be disposed in household trash if properly prepared',
            'Keep in original containers with personal information removed'
          ]
        }
    ),
    WasteItem(
        name: 'Paint Cans',
        icon: 'assets/images/paint_cans.png',
        category: 'Hazardous',
        isRecyclable: true,
        isOrganic: false,
        details: {
          'Disposal options': [
            'Latex paint: can be dried out and disposed in regular trash',
            'Oil-based paint: hazardous waste that requires special disposal',
            'Empty metal paint cans: can be recycled with other metals',
            'Many municipalities host hazardous waste collection events',
            'Some paint stores offer recycling programs'
          ]
        }
    ),

    WasteItem(
        name: 'Tetra Pak Cartons',
        icon: 'assets/images/tetra_pak.png',
        category: 'Composite',
        isRecyclable: true,
        isOrganic: false,
        details: {
          'Composition and recycling': [
            'Made of multiple layers (paper, aluminum, polyethylene)',
            'Increasingly accepted in recycling programs',
            'Should be rinsed and flattened before recycling',
            'Can be recycled into paper products, building materials, and other items',
            'Check local guidelines as acceptance varies by region'
          ]
        }
    ),
    WasteItem(
        name: 'Chemical Waste',
        icon: 'assets/images/chemical_waste.png',
        category: 'Hazardous',
        isRecyclable: false,
        isOrganic: false,
        details: {
          'Common household chemicals': [
            'Cleaning products and solvents',
            'Pesticides and herbicides',
            'Pool chemicals',
            'Automotive fluids',
            'Adhesives and sealants'
          ],
          'Safe disposal': [
            'Never pour down drains or on ground',
            'Keep in original containers with labels intact',
            'Dispose at household hazardous waste facilities',
            'Never mix different chemicals together',
            'Check for community collection events'
          ]
        }
    ),
    WasteItem(
        name: 'Rubber/Tires',
        icon: 'assets/images/rubber.png',
        category: 'Rubber',
        isRecyclable: true,
        isOrganic: false,
        details: {
          'Recycling applications': [
            'Tires can be shredded for playground surfaces',
            'Used in asphalt for roads',
            'Repurposed for garden planters or playground equipment',
            'Processed into fuel in some specialized facilities',
            'Small rubber items generally go in regular trash unless specialty recycling is available'
          ]
        }
    ),
  ];

  @override
  void initState() {
    super.initState();
    filteredItems = List.from(wasteItems);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void filterItems(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        filteredItems = List.from(wasteItems);
      } else {
        filteredItems = wasteItems
            .where((item) =>
        item.name.toLowerCase().contains(query.toLowerCase()) ||
            item.category.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Waste Dictionary',
                    style: TextStyle(
                      color: Color(0xFF00C853),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      onChanged: filterItems,
                      decoration: const InputDecoration(
                        hintText: 'Search type of waste here',
                        border: InputBorder.none,
                        icon: Icon(Icons.search, color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Categories',
                        style: TextStyle(
                          color: Color(0xFF00C853),
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '',
                        style: TextStyle(
                          color: Color(0xFF00C853),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.asset(
                        filteredItems[index].icon,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.delete_outline, color: Colors.grey);
                        },
                      ),
                    ),
                    title: Text(filteredItems[index].name),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WasteDetailPage(wasteItem: filteredItems[index]),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });

          // Navigate to the appropriate screen based on the tapped item
          if (index == 0) {
            // Home icon
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false, // This removes all previous routes
            );

          } else if (index == 1 || index == 3) {
            // Map or Profile icon
            // Already on Profile screen if index is 3
          } else if (index == 2) {
            // History icon
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PastEventsPage()),
            );
          }
        },
        selectedItemColor: const Color(0xFF4D8D6E),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Text('🏠', style: TextStyle(fontSize: 24)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Text('🗺️', style: TextStyle(fontSize: 24)),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Text('⏱️', style: TextStyle(fontSize: 24)),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Text('👤', style: TextStyle(fontSize: 24)),
            label: 'Profile',
          ),
        ],
      ),



    );
  }
}

class WasteDetailPage extends StatelessWidget {
  final WasteItem wasteItem;

  const WasteDetailPage({required this.wasteItem, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    wasteItem.name,
                    style: const TextStyle(
                      color: Color(0xFF00C853),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 160,
                    height: 160,
                    decoration: const BoxDecoration(
                      color: Color(0x4000C853),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset(
                        wasteItem.icon,
                        width: 100,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.delete_outline, color: Color(0xFF00C853), size: 80);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Recyclable',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: wasteItem.isRecyclable ? const Color(0xFF00C853) : Colors.grey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              wasteItem.isRecyclable ? 'Yes' : 'No',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 40),
                      Column(
                        children: [
                          const Text(
                            'Is organic',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: wasteItem.isOrganic ? const Color(0xFF00C853) : Colors.red,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              wasteItem.isOrganic ? 'Yes' : 'No',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: wasteItem.details.entries.map((entry) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.key,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...entry.value.map((item) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('• '),
                              Expanded(child: Text(item)),
                            ],
                          ),
                        );
                      }).toList(),
                      const SizedBox(height: 16),
                    ],
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class WasteItem {
  final String name;
  final String icon;
  final String category;
  final bool isRecyclable;
  final bool isOrganic;
  final Map<String, List<String>> details;

  const WasteItem({
    required this.name,
    required this.icon,
    required this.category,
    required this.isRecyclable,
    required this.isOrganic,
    required this.details,
  });
}