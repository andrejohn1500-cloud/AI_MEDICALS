import 'package:flutter/material.dart';

void main() {
  runApp(const AIMedicalsApp());
}

class AIMedicalsApp extends StatelessWidget {
  const AIMedicalsApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Medicals',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1565C0)),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = const [
    DiagnoseScreen(),
    HistoryScreen(),
    ProfileScreen(),
    EmergencyScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF1565C0),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Diagnose'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.warning_amber), label: 'Emergency'),
        ],
      ),
    );
  }
}

// DISCLAIMER BANNER
class DisclaimerBanner extends StatelessWidget {
  const DisclaimerBanner({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFFFF8E1),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: const Text(
        'This is a health information assistant only. Always consult a qualified healthcare professional.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 12, color: Color(0xFF795548)),
      ),
    );
  }
}

// DIAGNOSE SCREEN
class DiagnoseScreen extends StatefulWidget {
  const DiagnoseScreen({super.key});
  @override
  State<DiagnoseScreen> createState() => _DiagnoseScreenState();
}

class _DiagnoseScreenState extends State<DiagnoseScreen> {
  final _controller = TextEditingController();
  String _severity = 'Moderate';
  String _bodyArea = 'General';
  final _bodyAreas = ['General','Head','Chest','Back','Abdomen','Arms','Legs','Skin','Other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const DisclaimerBanner(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text('🩺 Symptom Triage',
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF1565C0))),
                    ),
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 4, bottom: 16),
                        child: Text('Describe your symptoms. Our AI will ask follow-up questions.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey)),
                      ),
                    ),
                    const Text('Body Area', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1565C0))),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _bodyArea,
                      decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                      items: _bodyAreas.map((a) => DropdownMenuItem(value: a, child: Text(a))).toList(),
                      onChanged: (v) => setState(() => _bodyArea = v!),
                    ),
                    const SizedBox(height: 16),
                    const Text('Describe Your Symptoms *',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1565C0))),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _controller,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'e.g. I have a headache and fever for 2 days...',
                        filled: true,
                        fillColor: const Color(0xFFF0F4FF),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Severity', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1565C0))),
                    Row(
                      children: ['Mild','Moderate','Severe'].map((s) => Expanded(
                        child: RadioListTile<String>(
                          title: Text(s, style: const TextStyle(fontSize: 13)),
                          value: s,
                          groupValue: _severity,
                          onChanged: (v) => setState(() => _severity = v!),
                          contentPadding: EdgeInsets.zero,
                        ),
                      )).toList(),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1565C0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {},
                        child: const Text('START AI TRIAGE →',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Center(
                      child: Text('⚠️ For emergencies call 911/999 or use the Emergency tab',
                        style: TextStyle(color: Colors.red, fontSize: 12)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// HISTORY SCREEN
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const DisclaimerBanner(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text('🕐 Triage History',
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF1565C0))),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView(
                        children: const [
                          Card(
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('No history yet', style: TextStyle(color: Colors.grey)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        onPressed: () {},
                        child: const Text('CLEAR HISTORY', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// PROFILE SCREEN
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const DisclaimerBanner(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(child: Text('👤 My Profile',
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF1565C0)))),
                    const SizedBox(height: 16),
                    _field('Full Name', 'Enter your name'),
                    _field('Age', 'Enter your age'),
                    const Text('Blood Type', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1565C0))),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                      items: ['A+','A-','B+','B-','O+','O-','AB+','AB-']
                        .map((b) => DropdownMenuItem(value: b, child: Text(b))).toList(),
                      onChanged: (_) {},
                      hint: const Text('Select blood type'),
                    ),
                    const SizedBox(height: 12),
                    _field('Known Medical Conditions', 'e.g. asthma, diabetes', lines: 2),
                    _field('Allergies', 'e.g. penicillin, shellfish', lines: 2),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1565C0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {},
                        child: const Text('SAVE PROFILE',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(String label, String hint, {int lines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1565C0))),
        const SizedBox(height: 8),
        TextField(
          maxLines: lines,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: const Color(0xFFF0F4FF),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
// EMERGENCY SCREEN
class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});
  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  final _langs = {
    'English':    {'emergency':'EMERGENCY','ambulance':'AMBULANCE','police':'POLICE','fire':'FIRE','hospital':'HOSPITAL','poison':'POISON CONTROL'},
    'French':     {'emergency':'URGENCE','ambulance':'AMBULANCE','police':'POLICE','fire':'POMPIERS','hospital':'HOPITAL','poison':'ANTIPOISON'},
    'Spanish':    {'emergency':'EMERGENCIA','ambulance':'AMBULANCIA','police':'POLICIA','fire':'BOMBEROS','hospital':'HOSPITAL','poison':'TOXICOLOGIA'},
    'Dutch':      {'emergency':'NOODGEVAL','ambulance':'AMBULANCE','police':'POLITIE','fire':'BRANDWEER','hospital':'ZIEKENHUIS','poison':'VERGIFTIGING'},
    'Hindi':      {'emergency':'AAPATKAAL','ambulance':'AMBULANCE','police':'POLICE','fire':'AGNI','hospital':'ASPATAAL','poison':'VISH NIYANTRAN'},
    'Mandarin':   {'emergency':'JINJI','ambulance':'JIUHOCHE','police':'JINGCHA','fire':'XIAOFANG','hospital':'YIYUAN','poison':'ZHONGDU'},
    'Russian':    {'emergency':'EKSTRENNAYA','ambulance':'SKORAYA','police':'POLITSIYA','fire':'POZHARNAYA','hospital':'BOLNITSA','poison':'OT OTRAVLENIY'},
    'Arabic':     {'emergency':'TAWAREI','ambulance':'ISAF','police':'SHURTA','fire':'ITFA','hospital':'MUSTASHFA','poison':'SUMUM'},
    'Islam':      {'emergency':'NAJDA','ambulance':'ISAF TIBBI','police':'SHURTA','fire':'ITFAA','hospital':'MUSTASHFA','poison':'SAMM'},
    'Greek':      {'emergency':'EKTAKTO','ambulance':'ASTHENOFORO','police':'ASTYNOMIA','fire':'PYROSVESTIKI','hospital':'NOSOKOMIO','poison':'DILHTIRIASEIS'},
    'Portuguese': {'emergency':'EMERGENCIA','ambulance':'AMBULANCIA','police':'POLICIA','fire':'BOMBEIROS','hospital':'HOSPITAL','poison':'VENENOS'},
    'Papiamento': {'emergency':'EMERGENCIA','ambulance':'AMBULANS','police':'POLITIE','fire':'BOMBERO','hospital':'HOSPITAL','poison':'VENENO'},
    'Creole':     {'emergency':'IJANS','ambulance':'ANBILANS','police':'LAPOLIS','fire':'PONPYE','hospital':'LOPITAL','poison':'PWAZON'},
  };

  final _data = {
    'St. Vincent and the Grenadines': [
      {'t':'emergency','n':'911','c':'#D32F2F'},{'t':'emergency','n':'999','c':'#D32F2F'},
      {'t':'ambulance','n':'784-456-1185','c':'#E65100'},{'t':'police','n':'784-457-1211','c':'#1565C0'},
      {'t':'fire','n':'784-456-1009','c':'#BF360C'},{'t':'hospital','n':'MILTON CATO 784-456-1185','c':'#2E7D32'},
    ],
    'Barbados': [
      {'t':'emergency','n':'211','c':'#D32F2F'},{'t':'ambulance','n':'511','c':'#E65100'},
      {'t':'police','n':'211','c':'#1565C0'},{'t':'fire','n':'311','c':'#BF360C'},
      {'t':'hospital','n':'QEH 246-436-6450','c':'#2E7D32'},{'t':'poison','n':'246-436-6450','c':'#6A1B9A'},
    ],
    'Trinidad and Tobago': [
      {'t':'emergency','n':'999','c':'#D32F2F'},{'t':'ambulance','n':'811','c':'#E65100'},
      {'t':'police','n':'999','c':'#1565C0'},{'t':'fire','n':'990','c':'#BF360C'},
      {'t':'hospital','n':'POS GEN HOSP 868-623-2951','c':'#2E7D32'},{'t':'poison','n':'868-623-2951','c':'#6A1B9A'},
    ],
    'Jamaica': [
      {'t':'emergency','n':'119','c':'#D32F2F'},{'t':'ambulance','n':'110','c':'#E65100'},
      {'t':'police','n':'119','c':'#1565C0'},{'t':'fire','n':'110','c':'#BF360C'},
      {'t':'hospital','n':'KPH 876-922-1434','c':'#2E7D32'},{'t':'poison','n':'876-927-1620','c':'#6A1B9A'},
    ],
    'Guyana': [
      {'t':'emergency','n':'911','c':'#D32F2F'},{'t':'ambulance','n':'913','c':'#E65100'},
      {'t':'police','n':'911','c':'#1565C0'},{'t':'fire','n':'912','c':'#BF360C'},
      {'t':'hospital','n':'GPHC 592-226-3271','c':'#2E7D32'},{'t':'poison','n':'592-226-3271','c':'#6A1B9A'},
    ],
    'Antigua and Barbuda': [
      {'t':'emergency','n':'911','c':'#D32F2F'},{'t':'ambulance','n':'462-0251','c':'#E65100'},
      {'t':'police','n':'462-0125','c':'#1565C0'},{'t':'fire','n':'462-0044','c':'#BF360C'},
      {'t':'hospital','n':'MT ST JOHN 462-0251','c':'#2E7D32'},{'t':'poison','n':'462-0251','c':'#6A1B9A'},
    ],
    'St. Lucia': [
      {'t':'emergency','n':'911','c':'#D32F2F'},{'t':'ambulance','n':'759-452-2421','c':'#E65100'},
      {'t':'police','n':'999','c':'#1565C0'},{'t':'fire','n':'911','c':'#BF360C'},
      {'t':'hospital','n':'VICTORIA HOSP 759-452-2421','c':'#2E7D32'},{'t':'poison','n':'759-452-2421','c':'#6A1B9A'},
    ],
    'Grenada': [
      {'t':'emergency','n':'911','c':'#D32F2F'},{'t':'ambulance','n':'434','c':'#E65100'},
      {'t':'police','n':'911','c':'#1565C0'},{'t':'fire','n':'911','c':'#BF360C'},
      {'t':'hospital','n':'GENERAL HOSP 473-440-2051','c':'#2E7D32'},{'t':'poison','n':'473-440-2051','c':'#6A1B9A'},
    ],
    'Dominica': [
      {'t':'emergency','n':'999','c':'#D32F2F'},{'t':'ambulance','n':'448-2231','c':'#E65100'},
      {'t':'police','n':'999','c':'#1565C0'},{'t':'fire','n':'998','c':'#BF360C'},
      {'t':'hospital','n':'PMH 767-448-2231','c':'#2E7D32'},{'t':'poison','n':'767-448-2231','c':'#6A1B9A'},
    ],
    'St. Kitts and Nevis': [
      {'t':'emergency','n':'911','c':'#D32F2F'},{'t':'ambulance','n':'465-2551','c':'#E65100'},
      {'t':'police','n':'465-2241','c':'#1565C0'},{'t':'fire','n':'911','c':'#BF360C'},
      {'t':'hospital','n':'JNF HOSPITAL 869-465-2551','c':'#2E7D32'},{'t':'poison','n':'869-465-2551','c':'#6A1B9A'},
    ],
    'Bahamas': [
      {'t':'emergency','n':'911','c':'#D32F2F'},{'t':'ambulance','n':'911','c':'#E65100'},
      {'t':'police','n':'919','c':'#1565C0'},{'t':'fire','n':'911','c':'#BF360C'},
      {'t':'hospital','n':'PMH 242-322-2861','c':'#2E7D32'},{'t':'poison','n':'242-322-2861','c':'#6A1B9A'},
    ],
    'Haiti': [
      {'t':'emergency','n':'114','c':'#D32F2F'},{'t':'ambulance','n':'114','c':'#E65100'},
      {'t':'police','n':'114','c':'#1565C0'},{'t':'fire','n':'115','c':'#BF360C'},
      {'t':'hospital','n':'HOPITAL GENERAL 509-2222-4000','c':'#2E7D32'},{'t':'poison','n':'509-2222-4000','c':'#6A1B9A'},
    ],
    'Cuba': [
      {'t':'emergency','n':'106','c':'#D32F2F'},{'t':'ambulance','n':'104','c':'#E65100'},
      {'t':'police','n':'106','c':'#1565C0'},{'t':'fire','n':'105','c':'#BF360C'},
      {'t':'hospital','n':'CIMEQ 537-838-3500','c':'#2E7D32'},{'t':'poison','n':'537-838-3500','c':'#6A1B9A'},
    ],
    'Dominican Republic': [
      {'t':'emergency','n':'911','c':'#D32F2F'},{'t':'ambulance','n':'911','c':'#E65100'},
      {'t':'police','n':'911','c':'#1565C0'},{'t':'fire','n':'911','c':'#BF360C'},
      {'t':'hospital','n':'HOSPITAL CONTRERAS 809-227-2221','c':'#2E7D32'},{'t':'poison','n':'809-562-0101','c':'#6A1B9A'},
    ],
    'Aruba': [
      {'t':'emergency','n':'911','c':'#D32F2F'},{'t':'ambulance','n':'911','c':'#E65100'},
      {'t':'police','n':'100','c':'#1565C0'},{'t':'fire','n':'115','c':'#BF360C'},
      {'t':'hospital','n':'DR HORACIO ODUBER 297-527-4000','c':'#2E7D32'},{'t':'poison','n':'297-527-4000','c':'#6A1B9A'},
    ],
    'Curacao': [
      {'t':'emergency','n':'912','c':'#D32F2F'},{'t':'ambulance','n':'912','c':'#E65100'},
      {'t':'police','n':'911','c':'#1565C0'},{'t':'fire','n':'912','c':'#BF360C'},
      {'t':'hospital','n':'CMC 599-9462-5100','c':'#2E7D32'},{'t':'poison','n':'599-9462-5100','c':'#6A1B9A'},
    ],
    'Sint Maarten': [
      {'t':'emergency','n':'911','c':'#D32F2F'},{'t':'ambulance','n':'912','c':'#E65100'},
      {'t':'police','n':'911','c':'#1565C0'},{'t':'fire','n':'913','c':'#BF360C'},
      {'t':'hospital','n':'ST MAARTEN MED CTR 721-543-1111','c':'#2E7D32'},{'t':'poison','n':'721-543-1111','c':'#6A1B9A'},
    ],
    'Suriname': [
      {'t':'emergency','n':'115','c':'#D32F2F'},{'t':'ambulance','n':'113','c':'#E65100'},
      {'t':'police','n':'115','c':'#1565C0'},{'t':'fire','n':'110','c':'#BF360C'},
      {'t':'hospital','n':'ACADEMISCH ZIEKENHUIS 597-442-222','c':'#2E7D32'},{'t':'poison','n':'597-442-222','c':'#6A1B9A'},
    ],
    'Belize': [
      {'t':'emergency','n':'911','c':'#D32F2F'},{'t':'ambulance','n':'911','c':'#E65100'},
      {'t':'police','n':'911','c':'#1565C0'},{'t':'fire','n':'911','c':'#BF360C'},
      {'t':'hospital','n':'KARL HEUSNER 501-223-1548','c':'#2E7D32'},{'t':'poison','n':'501-223-1548','c':'#6A1B9A'},
    ],
    'Montserrat': [
      {'t':'emergency','n':'911','c':'#D32F2F'},{'t':'ambulance','n':'491-2552','c':'#E65100'},
      {'t':'police','n':'491-2555','c':'#1565C0'},{'t':'fire','n':'911','c':'#BF360C'},
      {'t':'hospital','n':'GLENDON HOSP 664-491-2552','c':'#2E7D32'},{'t':'poison','n':'664-491-2552','c':'#6A1B9A'},
    ],
    'Cayman Islands': [
      {'t':'emergency','n':'911','c':'#D32F2F'},{'t':'ambulance','n':'911','c':'#E65100'},
      {'t':'police','n':'911','c':'#1565C0'},{'t':'fire','n':'911','c':'#BF360C'},
      {'t':'hospital','n':'HEALTH CITY 345-943-4628','c':'#2E7D32'},{'t':'poison','n':'345-943-4628','c':'#6A1B9A'},
    ],
    'Brazil': [
      {'t':'emergency','n':'190','c':'#D32F2F'},{'t':'ambulance','n':'192','c':'#E65100'},
      {'t':'police','n':'190','c':'#1565C0'},{'t':'fire','n':'193','c':'#BF360C'},
      {'t':'hospital','n':'SAMU 192','c':'#2E7D32'},{'t':'poison','n':'0800-722-6001','c':'#6A1B9A'},
    ],
    'Colombia': [
      {'t':'emergency','n':'123','c':'#D32F2F'},{'t':'ambulance','n':'125','c':'#E65100'},
      {'t':'police','n':'123','c':'#1565C0'},{'t':'fire','n':'119','c':'#BF360C'},
      {'t':'hospital','n':'LINEA SALUD 125','c':'#2E7D32'},{'t':'poison','n':'57-1-508-1030','c':'#6A1B9A'},
    ],
    'Venezuela': [
      {'t':'emergency','n':'911','c':'#D32F2F'},{'t':'ambulance','n':'171','c':'#E65100'},
      {'t':'police','n':'171','c':'#1565C0'},{'t':'fire','n':'171','c':'#BF360C'},
      {'t':'hospital','n':'HOSPITAL VARGAS 212-483-1343','c':'#2E7D32'},{'t':'poison','n':'212-483-1343','c':'#6A1B9A'},
    ],
    'Peru': [
      {'t':'emergency','n':'105','c':'#D32F2F'},{'t':'ambulance','n':'106','c':'#E65100'},
      {'t':'police','n':'105','c':'#1565C0'},{'t':'fire','n':'116','c':'#BF360C'},
      {'t':'hospital','n':'ESSALUD 411-8000','c':'#2E7D32'},{'t':'poison','n':'51-1-472-2500','c':'#6A1B9A'},
    ],
    'Argentina': [
      {'t':'emergency','n':'911','c':'#D32F2F'},{'t':'ambulance','n':'107','c':'#E65100'},
      {'t':'police','n':'101','c':'#1565C0'},{'t':'fire','n':'100','c':'#BF360C'},
      {'t':'hospital','n':'HOSPITAL ITALIANO 54-11-4959-0200','c':'#2E7D32'},{'t':'poison','n':'54-11-4923-1051','c':'#6A1B9A'},
    ],
    'Chile': [
      {'t':'emergency','n':'131','c':'#D32F2F'},{'t':'ambulance','n':'131','c':'#E65100'},
      {'t':'police','n':'133','c':'#1565C0'},{'t':'fire','n':'132','c':'#BF360C'},
      {'t':'hospital','n':'SAMU 131','c':'#2E7D32'},{'t':'poison','n':'56-2-2635-3800','c':'#6A1B9A'},
    ],
    'Ecuador': [
      {'t':'emergency','n':'911','c':'#D32F2F'},{'t':'ambulance','n':'911','c':'#E65100'},
      {'t':'police','n':'101','c':'#1565C0'},{'t':'fire','n':'102','c':'#BF360C'},
      {'t':'hospital','n':'HOSPITAL EUGENIO ESPEJO 593-2-226-2142','c':'#2E7D32'},{'t':'poison','n':'593-2-226-2142','c':'#6A1B9A'},
    ],
    'Bolivia': [
      {'t':'emergency','n':'110','c':'#D32F2F'},{'t':'ambulance','n':'118','c':'#E65100'},
      {'t':'police','n':'110','c':'#1565C0'},{'t':'fire','n':'119','c':'#BF360C'},
      {'t':'hospital','n':'HOSPITAL OBRERO 591-2-249-9141','c':'#2E7D32'},{'t':'poison','n':'591-2-249-9141','c':'#6A1B9A'},
    ],
    'Paraguay': [
      {'t':'emergency','n':'911','c':'#D32F2F'},{'t':'ambulance','n':'204','c':'#E65100'},
      {'t':'police','n':'911','c':'#1565C0'},{'t':'fire','n':'132','c':'#BF360C'},
      {'t':'hospital','n':'HOSPITAL NACIONAL 595-21-205-000','c':'#2E7D32'},{'t':'poison','n':'595-21-205-000','c':'#6A1B9A'},
    ],
    'Uruguay': [
      {'t':'emergency','n':'911','c':'#D32F2F'},{'t':'ambulance','n':'105','c':'#E65100'},
      {'t':'police','n':'911','c':'#1565C0'},{'t':'fire','n':'104','c':'#BF360C'},
      {'t':'hospital','n':'HOSPITAL MACIEL 598-2-915-3000','c':'#2E7D32'},{'t':'poison','n':'598-2-487-1515','c':'#6A1B9A'},
    ],
    'United States': [
      {'t':'emergency','n':'911','c':'#D32F2F'},{'t':'ambulance','n':'911','c':'#E65100'},
      {'t':'police','n':'911','c':'#1565C0'},{'t':'fire','n':'911','c':'#BF360C'},
      {'t':'hospital','n':'NURSE LINE 811','c':'#2E7D32'},{'t':'poison','n':'1-800-222-1222','c':'#6A1B9A'},
    ],
    'Canada': [
      {'t':'emergency','n':'911','c':'#D32F2F'},{'t':'ambulance','n':'911','c':'#E65100'},
      {'t':'police','n':'911','c':'#1565C0'},{'t':'fire','n':'911','c':'#BF360C'},
      {'t':'hospital','n':'TELEHEALTH 811','c':'#2E7D32'},{'t':'poison','n':'1-800-268-9017','c':'#6A1B9A'},
    ],
    'United Kingdom': [
      {'t':'emergency','n':'999','c':'#D32F2F'},{'t':'emergency','n':'112','c':'#D32F2F'},
      {'t':'ambulance','n':'999','c':'#E65100'},{'t':'police','n':'999','c':'#1565C0'},
      {'t':'fire','n':'999','c':'#BF360C'},{'t':'hospital','n':'NHS DIRECT 111','c':'#2E7D32'},
    ],
    'Australia': [
      {'t':'emergency','n':'000','c':'#D32F2F'},{'t':'ambulance','n':'000','c':'#E65100'},
      {'t':'police','n':'000','c':'#1565C0'},{'t':'fire','n':'000','c':'#BF360C'},
      {'t':'hospital','n':'HEALTHDIRECT 1800-022-222','c':'#2E7D32'},{'t':'poison','n':'13-11-26','c':'#6A1B9A'},
    ],
    'India': [
      {'t':'emergency','n':'112','c':'#D32F2F'},{'t':'ambulance','n':'108','c':'#E65100'},
      {'t':'police','n':'100','c':'#1565C0'},{'t':'fire','n':'101','c':'#BF360C'},
      {'t':'hospital','n':'MEDICAL HELPLINE 104','c':'#2E7D32'},{'t':'poison','n':'1800-116-117','c':'#6A1B9A'},
    ],
    'Nigeria': [
      {'t':'emergency','n':'112','c':'#D32F2F'},{'t':'ambulance','n':'112','c':'#E65100'},
      {'t':'police','n':'199','c':'#1565C0'},{'t':'fire','n':'199','c':'#BF360C'},
      {'t':'hospital','n':'LUTH 234-1-774-0780','c':'#2E7D32'},{'t':'poison','n':'112','c':'#6A1B9A'},
    ],
  };

  final _icons = {'emergency':'🆘','ambulance':'🚑','police':'👮','fire':'🔥','hospital':'🏥','poison':'☠️'};
  String _lang = 'English';
  String _country = 'St. Vincent and the Grenadines';

  Color _hex(String h) => Color(int.parse('FF${h.replaceAll('#','')}', radix: 16));

  @override
  Widget build(BuildContext context) {
    final t = _langs[_lang]!;
    final entries = _data[_country] ?? [];
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          const DisclaimerBanner(),
          Expanded(child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Center(child: Text('🚨 Emergency Contacts',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFD32F2F)))),
              const SizedBox(height: 12),
              const Text('🗣 Language', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1565C0), fontSize: 13)),
              const SizedBox(height: 4),
              DropdownButtonFormField<String>(
                value: _lang, isExpanded: true,
                decoration: InputDecoration(
                  filled: true, fillColor: const Color(0xFFE3F2FD),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none)),
                items: _langs.keys.map((l) => DropdownMenuItem(value: l, child: Text(l))).toList(),
                onChanged: (v) => setState(() => _lang = v!),
              ),
              const SizedBox(height: 10),
              const Text('🌍 Country', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1565C0), fontSize: 13)),
              const SizedBox(height: 4),
              DropdownButtonFormField<String>(
                value: _country, isExpanded: true,
                decoration: InputDecoration(
                  filled: true, fillColor: const Color(0xFFE8F5E9),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none)),
                items: _data.keys.map((c) => DropdownMenuItem(value: c, child: Text(c, overflow: TextOverflow.ellipsis))).toList(),
                onChanged: (v) => setState(() => _country = v!),
              ),
              const SizedBox(height: 14),
              ...entries.map((e) {
                final icon = _icons[e['t']] ?? '📞';
                final label = t[e['t']] ?? e['t']!.toUpperCase();
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _hex(e['c']!),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                    onPressed: () {},
                    child: Text('$icon $label — ${e['n']}',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                      textAlign: TextAlign.center)));
              }),
              const SizedBox(height: 8),
              const Center(child: Text('Tap any button to call directly',
                style: TextStyle(color: Colors.grey, fontSize: 13))),
            ]),
          )),
        ]),
      ),
    );
  }
}
