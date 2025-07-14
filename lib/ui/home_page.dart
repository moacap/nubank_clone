import 'package:flutter/material.dart';
import '../core/design_system/app_colors.dart';
import '../core/design_system/app_typography.dart';
import '../core/design_system/app_spacing.dart';
import '../core/design_system/app_radius.dart';
import '../core/design_system/app_theme.dart';
import 'package:nubank_clone/features/transactions/presentation/pages/transaction_page.dart';
import 'package:nubank_clone/features/customers/presentation/pages/customers_page.dart';

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
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: AppColors.accent,
            tabs: const [
              Tab(icon: Icon(Icons.dashboard), text: 'Início'),
              Tab(icon: Icon(Icons.person), text: 'Perfil'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Padding(
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
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: isTablet ? 4 : 2,
                      mainAxisSpacing: isTablet ? AppSpacing.lg : AppSpacing.md,
                      crossAxisSpacing: isTablet
                          ? AppSpacing.lg
                          : AppSpacing.md,
                      childAspectRatio: 1,
                      children: [
                        _HomeIconButton(
                          icon: Icons.account_balance_wallet,
                          label: 'Transações',
                          color: AppColors.primary,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const TransactionPage(),
                              ),
                            );
                          },
                        ),
                        _HomeIconButton(
                          icon: Icons.people,
                          label: 'Clientes',
                          color: AppColors.secondary,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const CustomersPage(),
                              ),
                            );
                          },
                        ),
                        _HomeIconButton(
                          icon: Icons.attach_money,
                          label: 'Investimentos',
                          color: AppColors.accent,
                          onTap: () {},
                        ),
                        _HomeIconButton(
                          icon: Icons.settings,
                          label: 'Configurações',
                          color: AppColors.border,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
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
      ),
    );
  }
}

// Widget de botão de ícone para o dashboard
class _HomeIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _HomeIconButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.md),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        padding: EdgeInsets.symmetric(
          vertical: isTablet ? AppSpacing.lg : AppSpacing.md,
          horizontal: AppSpacing.sm,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: isTablet ? 56 : 36, color: color),
            SizedBox(height: isTablet ? AppSpacing.md : AppSpacing.sm),
            Text(
              label,
              style: AppTypography.subtitle.copyWith(
                fontSize: isTablet ? 22 : 16,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
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
