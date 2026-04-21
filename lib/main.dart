import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const AIMedicalsApp());

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
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _idx = 0;
  final _screens = const [DiagnoseScreen(), HistoryScreen(), ProfileScreen(), EmergencyScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_idx],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _idx,
        onDestinationSelected: (i) => setState(() => _idx = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.medical_services), label: 'Diagnose'),
          NavigationDestination(icon: Icon(Icons.history), label: 'History'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
          NavigationDestination(icon: Icon(Icons.emergency), label: 'Emergency'),
        ],
      ),
    );
  }
}

// ── DIAGNOSE ────────────────────────────────────────────────────────────────
class DiagnoseScreen extends StatefulWidget {
  const DiagnoseScreen({super.key});
  @override
  State<DiagnoseScreen> createState() => _DiagnoseScreenState();
}

class _DiagnoseScreenState extends State<DiagnoseScreen> {
  final _ctrl = TextEditingController();
  String _result = '';
  bool _loading = false;

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Medicals'), backgroundColor: const Color(0xFF1565C0), foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 8),
            TextField(
              controller: _ctrl,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Describe your symptoms',
                hintText: 'e.g. headache, fever, sore throat for 2 days',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _loading ? null : _analyze,
                icon: const Icon(Icons.search),
                label: Text(_loading ? 'Analyzing...' : 'Analyze Symptoms'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1565C0),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (_loading) const CircularProgressIndicator(),
            if (_result.isNotEmpty)
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F2FD),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SingleChildScrollView(
                    child: Text(_result, style: const TextStyle(fontSize: 15)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _analyze() async {
    if (_ctrl.text.trim().isEmpty) return;
    setState(() { _loading = true; _result = ''; });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _loading = false;
      _result = 'AI analysis coming soon.\n\nYour symptoms: ${_ctrl.text.trim()}\n\nPhase 2 will connect to the Claude API for real diagnosis triage.';
    });
  }
}

// ── HISTORY ─────────────────────────────────────────────────────────────────
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('History'), backgroundColor: const Color(0xFF1565C0), foregroundColor: Colors.white),
      body: const Center(child: Text('No history yet.\nYour past diagnoses will appear here.', textAlign: TextAlign.center)),
    );
  }
}

// ── PROFILE ──────────────────────────────────────────────────────────────────
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _name = TextEditingController();
  final _age = TextEditingController();
  final _blood = TextEditingController();
  final _conditions = TextEditingController();
  bool _saved = false;

  @override
  void initState() { super.initState(); _load(); }

  @override
  void dispose() {
    _name.dispose(); _age.dispose(); _blood.dispose(); _conditions.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final p = await SharedPreferences.getInstance();
    setState(() {
      _name.text = p.getString('name') ?? '';
      _age.text = p.getString('age') ?? '';
      _blood.text = p.getString('blood') ?? '';
      _conditions.text = p.getString('conditions') ?? '';
    });
  }

  Future<void> _save() async {
    final p = await SharedPreferences.getInstance();
    await p.setString('name', _name.text);
    await p.setString('age', _age.text);
    await p.setString('blood', _blood.text);
    await p.setString('conditions', _conditions.text);
    setState(() => _saved = true);
    Future.delayed(const Duration(seconds: 2), () { if (mounted) setState(() => _saved = false); });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile'), backgroundColor: const Color(0xFF1565C0), foregroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Health Profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(controller: _name, decoration: const InputDecoration(labelText: 'Full Name', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: _age, decoration: const InputDecoration(labelText: 'Age', border: OutlineInputBorder()), keyboardType: TextInputType.number),
            const SizedBox(height: 12),
            TextField(controller: _blood, decoration: const InputDecoration(labelText: 'Blood Type', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: _conditions, decoration: const InputDecoration(labelText: 'Known Medical Conditions', hintText: 'e.g. asthma, diabetes', border: OutlineInputBorder()), maxLines: 2),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1565C0), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14)),
                child: const Text('Save Profile'),
              ),
            ),
            if (_saved) const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text('✅ Profile saved!', style: TextStyle(color: Colors.green)),
            ),
          ],
        ),
      ),
    );
  }
}

// ── EMERGENCY ────────────────────────────────────────────────────────────────
class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Emergency'), backgroundColor: Colors.red, foregroundColor: Colors.white),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _EmergencyCard(title: 'Milton Cato Memorial Hospital', number: '1-784-456-1185', icon: Icons.local_hospital),
          _EmergencyCard(title: 'Police', number: '911', icon: Icons.local_police),
          _EmergencyCard(title: 'Ambulance', number: '911', icon: Icons.emergency),
          _EmergencyCard(title: 'Fire Station', number: '911', icon: Icons.fire_truck),
        ],
      ),
    );
  }
}

class _EmergencyCard extends StatelessWidget {
  final String title, number;
  final IconData icon;
  const _EmergencyCard({required this.title, required this.number, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: Colors.red, size: 32),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(number, style: const TextStyle(fontSize: 16)),
        trailing: IconButton(
          icon: const Icon(Icons.call, color: Colors.green),
          onPressed: () {},
        ),
      ),
    );
  }
}
