import 'package:flutter/material.dart';
import '../core/design_system/app_colors.dart';
import '../core/design_system/app_typography.dart';
import '../core/design_system/app_spacing.dart';
import '../core/design_system/app_radius.dart';
import '../core/design_system/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;
    final titleFont = isTablet ? 32.0 : 22.0;
    final padding = isTablet ? 48.0 : 16.0;

    return Theme(
      data: AppTheme.light,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'NuBank Clone',
            style: AppTypography.title.copyWith(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: AppColors.primary,
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: isTablet ? AppSpacing.lg : AppSpacing.md),
                  Text(
                    'Olá, Usuário',
                    style: AppTypography.title.copyWith(fontSize: titleFont),
                  ),
                  SizedBox(height: isTablet ? AppSpacing.lg : AppSpacing.md),
                  // Card de saldo
                  _DashboardCard(
                    title: 'Saldo disponível',
                    value: 'R\$ 12.345,67',
                    icon: Icons.account_balance_wallet,
                    color: AppColors.primary,
                  ),
                  SizedBox(height: AppSpacing.md),
                  // Card de limite
                  _DashboardCard(
                    title: 'Limite do cartão',
                    value: 'R\$ 5.000,00',
                    icon: Icons.credit_card,
                    color: AppColors.secondary,
                  ),
                  SizedBox(height: AppSpacing.md),
                  // Gráfico de gastos (placeholder)
                  _DashboardChart(),
                  SizedBox(height: AppSpacing.md),
                  // Atalhos Pix, Recarga, Fatura
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _ShortcutButton(
                        icon: Icons.pix,
                        label: 'Pix',
                        color: AppColors.primary,
                        onTap: () {},
                      ),
                      _ShortcutButton(
                        icon: Icons.phone_android,
                        label: 'Recarga',
                        color: AppColors.secondary,
                        onTap: () {},
                      ),
                      _ShortcutButton(
                        icon: Icons.receipt_long,
                        label: 'Fatura',
                        color: AppColors.accent,
                        onTap: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.lg),
                  // Últimas transações (mock)
                  Text('Últimas transações', style: AppTypography.subtitle),
                  SizedBox(height: AppSpacing.sm),
                  _LastTransactionsList(),
                  SizedBox(height: AppSpacing.lg),
                  // Notificações (mock)
                  Text('Notificações', style: AppTypography.subtitle),
                  SizedBox(height: AppSpacing.sm),
                  _NotificationsList(),
                ],
              ),
            ),
            // Perfil Tab
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Center(
                child: _ProfileTab(isTablet: isTablet, titleFont: titleFont),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Material(
          color: AppColors.primary,
          child: TabBar(
            controller: _tabController,
            indicatorColor: AppColors.accent,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: const [
              Tab(icon: Icon(Icons.dashboard), text: 'Início'),
              Tab(icon: Icon(Icons.person), text: 'Perfil'),
            ],
          ),
        ),
      ),
    );
  }
}

// Card de saldo, limite, etc.
class _DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  const _DashboardCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Row(
          children: [
            Icon(icon, color: color, size: 36),
            SizedBox(width: AppSpacing.md),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.subtitle),
                Text(value, style: AppTypography.title.copyWith(color: color)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Gráfico de gastos (placeholder)
class _DashboardChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      elevation: 2,
      child: Container(
        height: 120,
        alignment: Alignment.center,
        child: Text(
          'Gráfico de gastos do mês (em breve)',
          style: AppTypography.body,
        ),
      ),
    );
  }
}

// Atalhos Pix, Recarga, Fatura
class _ShortcutButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _ShortcutButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.md),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 28),
            SizedBox(height: 4),
            Text(label, style: AppTypography.body.copyWith(color: color)),
          ],
        ),
      ),
    );
  }
}

// Lista de últimas transações (mock)
class _LastTransactionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = [
      {'title': 'Pix recebido', 'value': '+R\$ 500,00', 'color': Colors.green},
      {
        'title': 'Pagamento fatura',
        'value': '-R\$ 300,00',
        'color': Colors.red,
      },
      {'title': 'Transferência', 'value': '-R\$ 120,00', 'color': Colors.red},
      {'title': 'Depósito', 'value': '+R\$ 1.000,00', 'color': Colors.green},
    ];
    return Column(
      children: items
          .map(
            (item) => ListTile(
              leading: Icon(Icons.swap_horiz, color: item['color'] as Color),
              title: Text(item['title'] as String),
              trailing: Text(
                item['value'] as String,
                style: TextStyle(color: item['color'] as Color),
              ),
            ),
          )
          .toList(),
    );
  }
}

// Lista de notificações (mock)
class _NotificationsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'title': 'Fatura fechada',
        'subtitle': 'Sua fatura de julho está disponível.',
      },
      {'title': 'Promoção', 'subtitle': 'Ganhe cashback usando o cartão!'},
      {
        'title': 'Atualização',
        'subtitle': 'Novos recursos disponíveis no app.',
      },
    ];
    return Column(
      children: items
          .map(
            (item) => ListTile(
              leading: Icon(Icons.notifications, color: AppColors.primary),
              title: Text(item['title'] as String),
              subtitle: Text(item['subtitle'] as String),
            ),
          )
          .toList(),
    );
  }
}

// Widget da aba Perfil com foto, edição, animação e notificações
class _ProfileTab extends StatefulWidget {
  final bool isTablet;
  final double titleFont;
  const _ProfileTab({required this.isTablet, required this.titleFont});

  @override
  State<_ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<_ProfileTab>
    with SingleTickerProviderStateMixin {
  String name = 'Usuário NuBank';
  String email = 'user@nubank.com';
  String? photoUrl;
  bool editing = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animation = Tween<double>(
      begin: 0.9,
      end: 1.1,
    ).chain(CurveTween(curve: Curves.elasticInOut)).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _edit() {
    setState(() => editing = true);
  }

  void _save(String newName, String newEmail) {
    setState(() {
      name = newName;
      email = newEmail;
      editing = false;
    });
  }

  void _showNotifications() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Notificações'),
        content: const Text('Nenhuma notificação no momento.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final avatarSize = widget.isTablet ? 120.0 : 80.0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                _controller.forward(from: 0);
              },
              child: ScaleTransition(
                scale: _animation,
                child: CircleAvatar(
                  radius: avatarSize,
                  backgroundColor: const Color(0xFF820AD1),
                  backgroundImage: photoUrl != null
                      ? NetworkImage(photoUrl!)
                      : null,
                  child: photoUrl == null
                      ? Icon(
                          Icons.person,
                          size: avatarSize * 0.8,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.notifications),
              tooltip: 'Notificações',
              onPressed: _showNotifications,
              color: const Color(0xFF820AD1),
              iconSize: widget.isTablet ? 40 : 28,
            ),
          ],
        ),
        SizedBox(height: widget.isTablet ? 32 : 20),
        if (!editing) ...[
          Text(
            name,
            style: TextStyle(
              fontSize: widget.titleFont,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            email,
            style: TextStyle(
              fontSize: widget.isTablet ? 22 : 16,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: widget.isTablet ? 32 : 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.edit),
                label: const Text('Editar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00B4AA),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    vertical: widget.isTablet ? 20 : 14,
                    horizontal: 24,
                  ),
                  textStyle: TextStyle(fontSize: widget.isTablet ? 22 : 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: _edit,
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text('Sair'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF820AD1),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    vertical: widget.isTablet ? 20 : 14,
                    horizontal: 24,
                  ),
                  textStyle: TextStyle(fontSize: widget.isTablet ? 22 : 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
            ],
          ),
        ] else ...[
          _EditProfileForm(
            name: name,
            email: email,
            isTablet: widget.isTablet,
            onSave: _save,
            onCancel: () => setState(() => editing = false),
          ),
        ],
      ],
    );
  }
}

class _EditProfileForm extends StatefulWidget {
  final String name;
  final String email;
  final bool isTablet;
  final void Function(String, String) onSave;
  final VoidCallback onCancel;
  const _EditProfileForm({
    required this.name,
    required this.email,
    required this.isTablet,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<_EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<_EditProfileForm> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _emailController = TextEditingController(text: widget.email);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _nameController,
          decoration: const InputDecoration(labelText: 'Nome'),
          style: TextStyle(fontSize: widget.isTablet ? 22 : 16),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _emailController,
          decoration: const InputDecoration(labelText: 'E-mail'),
          style: TextStyle(fontSize: widget.isTablet ? 22 : 16),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () =>
                  widget.onSave(_nameController.text, _emailController.text),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00B4AA),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  vertical: widget.isTablet ? 20 : 14,
                  horizontal: 24,
                ),
                textStyle: TextStyle(fontSize: widget.isTablet ? 22 : 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text('Salvar'),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: widget.onCancel,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[400],
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(
                  vertical: widget.isTablet ? 20 : 14,
                  horizontal: 24,
                ),
                textStyle: TextStyle(fontSize: widget.isTablet ? 22 : 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text('Cancelar'),
            ),
          ],
        ),
      ],
    );
  }
}
