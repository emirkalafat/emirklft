import 'package:blog_web_site/widgets/page_header.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EquipmentView extends StatelessWidget {
  const EquipmentView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 800;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1400),
            padding: EdgeInsets.symmetric(
              horizontal: isSmall ? 24.0 : 80.0,
              vertical: 60,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. HEADER
                const PageHeader(
                  bigTitle: 'GEAR',
                  subtitle: '06 / Equipment',
                  title: 'Zanaatin\nAraçları.',
                  description:
                      'Dijital mimari için hassas enstrümanlar. Fiziksel ortamım, zihinsel çalışma alanımın bir uzantısıdır.',
                ),

                const SizedBox(height: 80),

                // 2. SECTIONS
                isSmall
                    ? Column(
                        children: [
                          _buildEquipmentSection(context, 'WORKSTATION', _workstationItems),
                          const SizedBox(height: 60),
                          _buildEquipmentSection(context, 'PERIPHERALS', _peripheralItems),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _buildEquipmentSection(context, 'WORKSTATION', _workstationItems)),
                          const SizedBox(width: 80),
                          Expanded(child: _buildEquipmentSection(context, 'PERIPHERALS', _peripheralItems)),
                        ],
                      ),
                
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEquipmentSection(BuildContext context, String title, List<EquipmentItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Row(
          children: [
            Text(
              title,
              style: GoogleFonts.spaceMono(
                textStyle: TextStyle(
                  color: Colors.white.withOpacity(0.4),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Container(
                height: 1,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),

        // Items List
        ...items.map((item) => _buildEquipmentCard(context, item)),
      ],
    );
  }

  Widget _buildEquipmentCard(BuildContext context, EquipmentItem item) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.01),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          // Icon with accent
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.02),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(
              item.icon,
              color: colorScheme.primary.withOpacity(0.6),
              size: 24,
            ),
          ),
          const SizedBox(width: 24),
          
          // Labels
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.category.toUpperCase(),
                  style: GoogleFonts.spaceMono(
                    textStyle: TextStyle(
                      color: colorScheme.primary,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EquipmentItem {
  final String name;
  final String category;
  final IconData icon;

  const EquipmentItem({required this.name, required this.category, required this.icon});
}

// DATA
const _workstationItems = [
  EquipmentItem(name: 'AMD Ryzen 9 7950X3D', category: 'CPU', icon: Icons.memory),
  EquipmentItem(name: 'NVIDIA GeForce RTX 4090', category: 'GPU', icon: Icons.developer_board),
  EquipmentItem(name: '64GB DDR5 6000MHz', category: 'RAM', icon: Icons.straighten),
  EquipmentItem(name: '2TB NVMe M.2 Gen4', category: 'Storage', icon: Icons.save),
  EquipmentItem(name: 'Fractal Design North', category: 'Case', icon: Icons.inventory_2),
];

const _peripheralItems = [
  EquipmentItem(name: 'Pro Studio Display', category: 'Monitor', icon: Icons.monitor),
  EquipmentItem(name: 'Custom HHKB', category: 'Keyboard', icon: Icons.keyboard),
  EquipmentItem(name: 'Logitech MX Master 3S', category: 'Mouse', icon: Icons.mouse),
  EquipmentItem(name: 'Shure SM7B', category: 'Microphone', icon: Icons.mic),
  EquipmentItem(name: 'Sony A7IV', category: 'Camera', icon: Icons.camera_alt),
];
