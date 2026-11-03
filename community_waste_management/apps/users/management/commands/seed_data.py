import random
from datetime import datetime, timedelta
from django.core.management.base import BaseCommand
from django.contrib.auth import get_user_model
from django.db import transaction

User = get_user_model()


class Command(BaseCommand):
    help = '为社区垃圾分类管理系统填充测试数据'

    def add_arguments(self, parser):
        parser.add_argument('--clean', action='store_true', help='清空已有数据后重新填充')

    @transaction.atomic
    def handle(self, *args, **options):
        if options['clean']:
            self.stdout.write(self.style.WARNING('正在清空已有数据...'))
            self._clean_data()

        self.stdout.write(self.style.SUCCESS('开始填充数据...'))
        self._seed_users()
        categories = self._seed_categories()
        points = self._seed_points()
        products = self._seed_products()
        activities = self._seed_activities()
        guide_cats = self._seed_guides()
        self._seed_records(categories, points)
        self._seed_transactions()
        self._seed_orders(products)
        self._seed_activity_participants(activities)
        self._seed_notifications()
        self._seed_feedbacks()
        self._seed_evaluations(points)
        self._seed_violations(points)
        self._seed_faqs(guide_cats)
        self.stdout.write(self.style.SUCCESS('数据填充完成！'))

    def _clean_data(self):
        from apps.feedback.models import Feedback, PointEvaluation, ViolationReport
        from apps.guides.models import GuideItem, FAQ, GuideCategory
        from apps.activities.models import Notification, ActivityParticipant, Activity
        from apps.products.models import Order, Product
        from apps.waste_records.models import WasteRecord, PointTransaction, WasteCategory
        from apps.points.models import Sensor, WastePoint
        from apps.users.models import House

        ViolationReport.objects.all().delete()
        PointEvaluation.objects.all().delete()
        Feedback.objects.all().delete()
        Notification.objects.all().delete()
        ActivityParticipant.objects.all().delete()
        Activity.objects.all().delete()
        Order.objects.all().delete()
        Product.objects.all().delete()
        WasteRecord.objects.all().delete()
        PointTransaction.objects.all().delete()
        WasteCategory.objects.all().delete()
        Sensor.objects.all().delete()
        WastePoint.objects.all().delete()
        House.objects.all().delete()

        users = User.objects.filter(is_superuser=False)
        count = users.count()
        users.delete()
        self.stdout.write(f'  已删除 {count} 个普通用户')

    def _seed_users(self):
        if User.objects.filter(is_superuser=False).exists():
            self.stdout.write('  用户数据已存在，跳过')
            return

        surnames = ['张', '李', '王', '刘', '陈', '杨', '赵', '黄', '周', '吴',
                    '徐', '孙', '马', '朱', '胡', '郭', '何', '林', '罗', '郑']
        names_male = ['伟', '强', '磊', '军', '勇', '杰', '涛', '明', '超', '华',
                      '鹏', '辉', '志', '斌', '刚', '波', '宇', '浩', '凯', '俊']
        names_female = ['芳', '娜', '敏', '静', '丽', '艳', '玲', '雪', '婷', '慧',
                        '琳', '萍', '红', '梅', '燕', '霞', '倩', '颖', '晶', '薇']
        roles = ['resident', 'resident', 'resident', 'resident', 'resident',
                 'inspector', 'property']
        levels = ['新手', '初级', '中级', '高级', '专家']

        created = 0
        base_time = datetime(2025, 1, 1)
        for i in range(50):
            surname = random.choice(surnames)
            is_female = random.random() > 0.55
            name = random.choice(names_female if is_female else names_male)
            username = f'{surname}{name}{random.randint(10, 99)}'
            role = random.choice(roles)

            user = User(
                username=username,
                email=f'{username.lower()}@example.com',
                first_name=surname,
                last_name=name,
                phone_number=f'138{random.randint(10000000, 99999999)}',
                role=role,
                family_members=random.randint(1, 5),
                points=random.randint(0, 5000),
                level=random.choices(levels, weights=[30, 25, 20, 15, 10])[0],
                is_active=True,
                created_at=base_time + timedelta(days=random.randint(0, 450)),
            )
            password = 'password123'
            user.set_password(password)
            user.save()
            created += 1

            buildings = ['A栋', 'B栋', 'C栋', 'D栋', 'E栋']
            units = [f'{i}单元' for i in range(1, 7)]
            rooms = [f'{j:02d}01' for j in range(1, 25)]

            if role == 'resident':
                House.objects.create(
                    user=user,
                    building=random.choice(buildings),
                    unit=random.choice(units),
                    room=random.choice(rooms),
                    is_verified=True,
                )

        admin_user = User.objects.filter(is_superuser=True).first()
        if not admin_user:
            admin_user = User(
                username='admin',
                email='admin@waste.com',
                first_name='管理',
                last_name='员',
                role='admin',
                is_staff=True,
                is_superuser=True,
                is_active=True,
                points=0,
                level='管理员',
            )
            admin_user.set_password('admin123')
            admin_user.save()
            created += 1

        self.stdout.write(f'  已创建 {created} 个用户')

    def _seed_categories(self):
        from apps.waste_records.models import WasteCategory
        if WasteCategory.objects.exists():
            self.stdout.write('  垃圾类别已存在，跳过')
            return list(WasteCategory.objects.all())

        categories = [
            ('可回收物', '包括废纸、塑料、玻璃、金属、布料等可循环利用的废弃物', 2),
            ('厨余垃圾', '包括剩菜剩饭、果皮菜叶、过期食品等易腐烂的有机废弃物', 1),
            ('有害垃圾', '包括废电池、废灯管、废药品、废油漆等对人体有害的废弃物', 3),
            ('其他垃圾', '除上述三类之外的其他生活废弃物，如砖瓦陶瓷、卫生纸等', 1),
        ]
        created = []
        for name, desc, pv in categories:
            cat = WasteCategory.objects.create(name=name, description=desc, point_value=pv)
            created.append(cat)
        self.stdout.write(f'  已创建 {len(created)} 个垃圾类别')
        return created

    def _seed_points(self):
        from points.models import WastePoint, Sensor
        if WastePoint.objects.exists():
            self.stdout.write('  投放点已存在，跳过')
            return list(WastePoint.objects.all())

        point_data = [
            ('小区东门投放点', '小区东门入口处', '智能回收站', 200, 30, 'normal'),
            ('1号楼投放点', '1号楼楼下北侧', '标准分类桶', 100, 65, 'normal'),
            ('2号楼投放点', '2号楼楼下南侧', '标准分类桶', 100, 88, 'full'),
            ('3号楼投放点', '3号楼楼下东侧', '智能回收站', 150, 42, 'normal'),
            ('4号楼投放点', '4号楼楼下西侧', '标准分类桶', 100, 55, 'warning'),
            ('中心花园投放点', '社区中心花园旁', '大型分类站', 300, 28, 'normal'),
            ('西门投放点', '小区西门出口处', '标准分类桶', 80, 72, 'normal'),
            ('北门投放点', '小区北门停车场旁', '智能回收站', 180, 45, 'normal'),
            ('幼儿园投放点', '社区幼儿园门口', '小型分类点', 60, 35, 'normal'),
            ('物业楼投放点', '物业管理处旁边', '综合分类站', 250, 20, 'normal'),
        ]
        sensor_types = ['重量传感器', '满溢传感器', '温度传感器', '湿度传感器', '摄像头']

        created_points = []
        for name, loc, ptype, cap, fill, status in point_data:
            wp = WastePoint.objects.create(
                name=name, location=loc, type=ptype,
                capacity=cap, current_fill=cap * fill / 100,
                fill_level=fill, status=status,
                latitude=39.9 + random.uniform(-0.02, 0.02),
                longitude=116.4 + random.uniform(-0.03, 0.03),
                open_time=datetime.now().replace(hour=6, minute=0, second=0).time(),
                close_time=datetime.now().replace(hour=22, minute=0, second=0).time(),
                accepted_categories='可回收物,厨余垃圾,有害垃圾,其他垃圾',
                last_cleaned=datetime.now() - timedelta(days=random.randint(0, 7)),
                next_cleanup=datetime.now() + timedelta(days=random.randint(1, 5)),
            )
            for j in range(random.randint(1, 3)):
                Sensor.objects.create(
                    waste_point=wp,
                    sensor_type=random.choice(sensor_types),
                    sensor_id=f'SNS-{wp.id}-{j+1:03d}',
                    is_active=random.random() > 0.1,
                    last_reading=datetime.now() - timedelta(minutes=random.randint(5, 120)),
                )
            created_points.append(wp)

        self.stdout.write(f'  已创建 {len(created_points)} 个投放点和传感器')
        return created_points

    def _seed_products(self):
        from apps.products.models import Product
        if Product.objects.exists():
            self.stdout.write('  商品已存在，跳过')
            return list(Product.objects.all())

        product_data = [
            ('环保购物袋', '可重复使用的环保帆布购物袋，结实耐用', 50, 8, 200, True),
            ('便携餐具套装', '不锈钢筷子+勺子+叉子三件套', 80, 12, 150, True),
            ('垃圾分类贴纸', '四色分类标识贴纸一套', 20, 3, 500, True),
            ('有机肥料', '厨余堆肥制成的有机花肥500g', 100, 15, 80, True),
            ('环保水杯', '304不锈钢保温杯500ml', 200, 35, 60, True),
            ('竹制牙刷', '天然竹柄软毛牙刷10支装', 40, 6, 300, True),
            ('垃圾分类指南手册', '图文并茂的分类指导手册', 30, 5, 400, True),
            ('可降解垃圾袋', 'PLA材质中号垃圾袋100只', 60, 10, 250, True),
            ('植物种子包', '蔬菜/花卉混合种子礼包', 90, 14, 120, True),
            ('环保笔记本', '再生纸制作的记事本', 45, 7, 180, True),
            ('LED节能灯泡', '5W暖白光LED灯泡', 70, 11, 130, True),
            ('垃圾分类游戏棋', '亲子互动垃圾分类教育玩具', 150, 22, 40, True),
            ('手提编织篮', '天然藤编手提篮', 180, 28, 50, True),
            ('除味炭包', '活性炭除味包200g', 25, 4, 350, True),
            ('积分兑换券', '合作商家通用优惠券', 200, 0, 100, True),
        ]
        created = []
        for name, desc, pts, price, stock, active in product_data:
            p = Product.objects.create(
                name=name, description=desc, points_required=pts,
                price=price, stock=stock, is_active=active,
                image_url='',
            )
            created.append(p)

        self.stdout.write(f'  已创建 {len(created)} 个商品')
        return created

    def _seed_activities(self):
        from apps.activities.models import Activity
        if Activity.objects.exists():
            self.stdout.write('  活动已存在，跳过')
            return list(Activity.objects.all())

        now = datetime.now()
        activity_data = [
            ('世界地球日宣传活动', '地球日', '社区广场举办环保知识讲座和互动游戏，参与即可获得积分奖励', now - timedelta(days=30), now - timedelta(days=23), 50),
            ('垃圾分类达人赛', '分类比赛', '居民分组进行垃圾分类速度和准确率比拼，优胜者获得丰厚奖品', now - timedelta(days=15), now - timedelta(days=8), 100),
            ('绿色家庭评选活动', '绿色家庭', '评选社区内践行环保理念的优秀家庭，颁发荣誉证书和奖品', now + timedelta(days=5), now + timedelta(days=26), 200),
            ('旧衣回收公益行', '公益活动', '收集家中闲置衣物进行统一回收处理，按重量获得积分', now + timedelta(days=30), now + timedelta(days=44), 80),
            ('环保手工DIY workshop', '手工制作', '用废旧物品制作实用工艺品，培养环保意识', now + timedelta(days=50), now + timedelta(days=51), 60),
            ('社区清洁志愿行动', '志愿服务', '组织志愿者对社区公共区域进行深度清洁', now + timedelta(days=60), now + timedelta(days=61), 40),
            ('儿童环保绘画比赛', '绘画比赛', '面向社区儿童的环保主题绘画征集活动', now + timedelta(days=75), now + timedelta(days=95), 100),
            ('厨余堆肥体验课', '培训课程', '学习如何将厨余垃圾转化为有机肥料', now + timedelta(days=100), now + timedelta(days=101), 30),
        ]
        created = []
        for title, name, desc, start, end, reward in activity_data:
            act = Activity.objects.create(
                title=title, name=name, description=desc,
                start_date=start, end_date=end,
                reward_points=reward, is_active=end > now,
            )
            created.append(act)

        self.stdout.write(f'  已创建 {len(created)} 个活动')
        return created

    def _seed_guides(self):
        from guides.models import GuideCategory, GuideItem
        if GuideCategory.objects.exists():
            self.stdout.write('  分类指南已存在，跳过')
            return list(GuideCategory.objects.all())

        cat_data = [
            ('可回收物指南', ''),
            ('厨余垃圾指南', ''),
            ('有害垃圾指南', ''),
            ('其他垃圾指南', ''),
            ('分类技巧', ''),
        ]
        cats = []
        for cname, icon in cat_data:
            c = GuideCategory.objects.create(name=cname, icon_url=icon)
            cats.append(c)

        guide_items = [
            (cats[0], '纸张类如何正确回收', '报纸、杂志、书本、打印纸等应保持干燥平整，折叠后投入蓝色可回收物容器。避免混入油污或湿水的纸张。', '', ''),
            (cats[0], '塑料瓶回收前要做什么', '塑料瓶回收前请倒空内容物，简单冲洗干净，压扁后投放。瓶盖和瓶身如材质相同可一起投放。', '', ''),
            (cats[0], '玻璃制品回收注意事项', '玻璃制品应小心轻放，避免破碎。碎玻璃应用厚纸包裹并标注"内有碎玻璃"后再投放。镜子不属于可回收物。', '', ''),
            (cats[0], '金属罐头的处理方法', '易拉罐、奶粉罐等金属容器需倒空清洗，尽量压扁以节省空间。注意尖锐边缘安全。', '', ''),
            (cats[1], '厨余垃圾投放要点', '厨余垃圾应沥干水分后投放，去除包装袋。大块骨头、硬壳类物品属于其他垃圾。', '', ''),
            (cats[1], '常见厨余垃圾清单', '剩饭剩菜、瓜皮果核、蛋壳、茶叶渣、枯枝落叶、宠物饲料等都属于厨余垃圾。', '', ''),
            (cats[1], '厨余垃圾的处理意义', '厨余垃圾经过专业处理后可转化为有机肥料和生物燃气，实现资源循环利用。', '', ''),
            (cats[2], '废电池的正确处置', '各类电池（干电池、充电电池、纽扣电池）都属于有害垃圾，请投入红色有害垃圾桶。不要随意丢弃。', '', ''),
            (cats[2], '过期药品如何处理', '过期药品及其包装应整体投入有害垃圾桶。不要将药品冲入下水道。', '', ''),
            (cats[2], '灯管和温度计的处理', '荧光灯管、节能灯、水银温度计含汞，属于有害垃圾。破损时需小心处理防止汞泄漏。', '', ''),
            (cats[3], '其他垃圾包含哪些', '受污染纸张、烟蒂、陶瓷碎片、一次性餐具、卫生巾、尿不湿等都属于其他垃圾。', '', ''),
            (cats[3], '大件垃圾怎么处理', '家具、家电等大件垃圾不应投入普通垃圾桶，请联系物业或专业回收公司上门处理。', '', ''),
            (cats[4], '快速分类口诀', '能卖钱的可回收，易腐烂的是厨余，有毒有害单独放，其余全部其他类。', '', ''),
            (cats[4], '不确定时怎么办', '遇到不确定的垃圾，可以查阅官方分类指南或使用手机扫码查询功能。', '', ''),
        ]

        for cat, title, content, img, vid in guide_items:
            GuideItem.objects.create(
                category=cat, title=title, content=content,
                image_url=img, video_url=vid, is_active=True,
            )

        self.stdout.write(f'  已创建 {len(cats)} 个分类指南和 {len(guide_items)} 条指南内容')
        return cats

    def _seed_records(self, categories, waste_points):
        from apps.waste_records.models import WasteRecord
        if WasteRecord.objects.exists():
            self.stdout.write('  投放记录已存在，跳过')
            return

        residents = list(User.objects.filter(role='resident'))[:30]
        if not residents:
            self.stdout.write('  没有居民用户，跳过投放记录')
            return

        now = datetime.now()
        records_created = 0
        for i in range(120):
            user = random.choice(residents)
            wp = random.choice(waste_points)
            cat = random.choice(categories)
            weight = round(random.uniform(0.5, 8.0), 1)
            qualified = random.random() > 0.12
            points = int(weight * cat.point_value) if qualified else 0

            rec = WasteRecord.objects.create(
                user=user, waste_point=wp, category=cat,
                weight=weight, points_earned=points,
                is_qualified=qualified, image_url='',
                created_at=now - timedelta(days=random.randint(0, 90),
                                           hours=random.randint(0, 23),
                                           minutes=random.randint(0, 59)),
            )
            records_created += 1

        self.stdout.write(f'  已创建 {records_created} 条投放记录')

    def _seed_transactions(self):
        from waste_records.models import PointTransaction
        if PointTransaction.objects.exists():
            self.stdout.write('  积分交易已存在，跳过')
            return

        all_users = list(User.objects.exclude(is_superuser=True))[:35]
        if not all_users:
            self.stdout.write('  没有用户，跳过积分交易')
            return

        earn_descs = [
            '投放可回收物获得积分', '投放厨余垃圾获得积分', '参与活动奖励',
            '每日签到奖励', '连续打卡奖励', '邀请邻居奖励',
            '正确分类奖励', '参与问卷调查', '绿色出行奖励',
        ]
        spend_descs = [
            '兑换环保购物袋', '兑换便携餐具', '兑换垃圾分类贴纸',
            '兑换有机肥料', '兑换环保水杯', '兑换竹制牙刷',
            '兑换环保笔记本', '兑换LED灯泡', '兑换兑换券',
        ]

        now = datetime.now()
        tx_count = 0
        for user in all_users:
            num_tx = random.randint(5, 20)
            for _ in range(num_tx):
                is_earn = random.random() > 0.35
                if is_earn:
                    pts = random.randint(5, 50)
                    desc = random.choice(earn_descs)
                    ttype = 'earn'
                else:
                    pts = random.randint(20, 200)
                    desc = random.choice(spend_descs)
                    ttype = 'spend'

                PointTransaction.objects.create(
                    user=user, points=pts,
                    transaction_type=ttype, description=desc,
                    created_at=now - timedelta(days=random.randint(0, 90),
                                               hours=random.randint(0, 23)),
                )
                tx_count += 1

        self.stdout.write(f'  已创建 {tx_count} 条积分交易记录')

    def _seed_orders(self, products):
        from products.models import Order
        if Order.objects.exists():
            self.stdout.write('  订单已存在，跳过')
            return

        residents = list(User.objects.filter(role='resident'))[:30]
        if not residents or not products:
            self.stdout.write('  缺少用户或商品，跳过订单')
            return

        status_choices = ['completed'] * 60 + ['pending'] * 25 + ['cancelled'] * 15
        now = datetime.now()
        order_count = 0

        for _ in range(80):
            user = random.choice(residents)
            prod = random.choice(products)
            qty = random.randint(1, 3)
            total = prod.points_required * qty

            Order.objects.create(
                user=user, product=prod,
                quantity=qty, total_points=total,
                status=random.choice(status_choices),
                created_at=now - timedelta(days=random.randint(0, 60),
                                          hours=random.randint(0, 23)),
            )
            order_count += 1

        self.stdout.write(f'  已创建 {order_count} 个订单')

    def _seed_activity_participants(self, activities):
        from apps.activities.models import ActivityParticipant
        if ActivityParticipant.objects.exists():
            self.stdout.write('  活动参与记录已存在，跳过')
            return

        residents = list(User.objects.filter(role='resident'))[:30]
        if not residents or not activities:
            self.stdout.write('  缺少用户或活动，跳过参与记录')
            return

        part_count = 0
        for act in activities[:5]:
            num_parts = random.randint(8, 25)
            chosen = random.sample(residents, min(num_parts, len(residents)))
            for user in chosen:
                completed = act.end_date < datetime.now()
                ActivityParticipant.objects.create(
                    user=user, activity=act,
                    points_earned=act.reward_points // 4 + random.randint(0, 20) if completed else 0,
                    is_completed=completed,
                    joined_at=act.start_date + timedelta(hours=random.randint(0, 48)),
                )
                part_count += 1

        self.stdout.write(f'  已创建 {part_count} 条活动参与记录')

    def _seed_notifications(self):
        from apps.activities.models import Notification
        if Notification.objects.exists():
            self.stdout.write('  通知消息已存在，跳过')
            return

        all_users = list(User.objects.exclude(is_superuser=True))[:30]
        if not all_users:
            self.stdout.write('  没有用户，跳过通知')
            return

        titles = [
            ('系统公告：垃圾分类新规上线', 'system', '亲爱的居民，新的垃圾分类管理规定将于下周起正式实施，请大家认真学习。'),
            ('您的积分到账通知', 'system', '您最近的垃圾分类投放获得了新的积分奖励，快去查看吧！'),
            ('活动提醒：本周末环保活动', 'activity', '本周末将在社区广场举办环保主题活动，欢迎参加！'),
            ('订单状态更新', 'order', '您兑换的商品已准备就绪，请前往物业处领取。'),
            ('投放点维护通知', 'system', '部分投放点将于明日进行例行维护，届时暂停使用。'),
            ('积分商城新品上架', 'product', '积分商城新增了多款环保商品，快来选购吧！'),
            ('月度环保之星评选结果', 'system', '恭喜您被评为本月环保之星，额外获得200积分奖励！'),
            ('投放异常提醒', 'system', '检测到您近期的投放合格率有所下降，请注意分类准确性。'),
            ('节日祝福', 'system', '值此佳节之际，祝您和家人身体健康，万事如意！'),
            ('账户安全提示', 'system', '检测到您的账号在新设备登录，如非本人操作请及时修改密码。'),
        ]
        ntypes = ['system', 'activity', 'order', 'product']
        now = datetime.now()
        noti_count = 0

        for user in all_users:
            num_noti = random.randint(3, 10)
            chosen = random.sample(titles, min(num_noti, len(titles)))
            for title, ntype, content in chosen:
                Notification.objects.create(
                    user=user, title=title,
                    content=content, notification_type=ntype,
                    type='', is_read=random.random() > 0.4,
                    created_at=now - timedelta(days=random.randint(0, 30),
                                              hours=random.randint(0, 23)),
                )
                noti_count += 1

        self.stdout.write(f'  已创建 {noti_count} 条通知消息')

    def _seed_feedbacks(self):
        from apps.feedback.models import Feedback
        if Feedback.objects.exists():
            self.stdout.write('  反馈已存在，跳过')
            return

        residents = list(User.objects.filter(role='resident'))[:25]
        if not residents:
            self.stdout.write('  没有用户，跳过反馈')
            return

        fb_titles = [
            ('建议增加夜间投放时间', '希望投放点的开放时间能延长到晚上10点以后，方便上班族使用。'),
            ('投放点容量不足', '3号楼的投放点经常满溢，建议增加清理频次或更换更大容量的设备。'),
            ('表扬保洁人员工作认真', '想特别表扬负责东门投放点的王师傅，工作非常认真负责！'),
            ('APP功能建议', '希望能增加投放记录导出功能和月度统计图表。'),
            ('分类标识不够清晰', '部分投放点的分类标识褪色了，建议定期更换。'),
            ('申请增设有害垃圾专用箱', '我们这栋楼的有害垃圾产生量较大，希望能设专用的收集箱。'),
            ('积分兑换商品太少', '积分商城的商品种类偏少，希望能增加更多选择。'),
            ('建议开展更多线下活动', '希望能多举办一些亲子参与的环保教育活动。'),
            ('投放点卫生问题反馈', '最近发现某投放点周围有异味和蚊虫问题，需要关注。'),
            ('感谢系统的便利性', '使用这个系统已经半年了，感觉越来越方便了，感谢开发团队！'),
        ]
        statuses = ['processed'] * 50 + ['pending'] * 35 + ['closed'] * 15
        now = datetime.now()
        fb_count = 0

        for _ in range(60):
            user = random.choice(residents)
            title, content = random.choice(fb_titles)
            Feedback.objects.create(
                user=user, title=title,
                content=content + '\n\n（这是自动生成的测试反馈数据）',
                image_url='', status=random.choice(statuses),
                created_at=now - timedelta(days=random.randint(0, 60)),
            )
            fb_count += 1

        self.stdout.write(f'  已创建 {fb_count} 条用户反馈')

    def _seed_evaluations(self, waste_points):
        from apps.feedback.models import PointEvaluation
        if PointEvaluation.objects.exists():
            self.stdout.write('  评分评价已存在，跳过')
            return

        residents = list(User.objects.filter(role='resident'))[:25]
        if not residents or not waste_points:
            self.stdout.write('  缺少用户或投放点，跳过评价')
            return

        ev_count = 0
        now = datetime.now()
        for wp in waste_points:
            num_ev = random.randint(5, 15)
            for _ in range(num_ev):
                user = random.choice(residents)
                clean = random.randint(3, 5) if random.random() > 0.2 else random.randint(1, 3)
                equip = random.randint(3, 5) if random.random() > 0.15 else random.randint(1, 3)
                comments = ['', '环境整洁', '设施完好', '服务态度好', '位置方便',
                            '需要改进卫生', '设备有点旧', '总体不错'][random.randint(0, 7)]

                PointEvaluation.objects.create(
                    user=user, waste_point=wp,
                    cleanliness=clean, equipment_status=equip,
                    comment=comments, image_url='',
                    created_at=now - timedelta(days=random.randint(0, 90)),
                )
                ev_count += 1

        self.stdout.write(f'  已创建 {ev_count} 条评分评价')

    def _seed_violations(self, waste_points):
        from apps.feedback.models import ViolationReport
        if ViolationReport.objects.exists():
            self.stdout.write('  违规举报已存在，跳过')
            return

        residents = list(User.objects.filter(role='resident'))[:25]
        if not residents or not waste_points:
            self.stdout.write('  缺少用户或投放点，跳过违规举报')
            return

        viol_descs = [
            '发现有人将建筑垃圾混入生活垃圾投放。',
            '有人未按规定时间在非投放时段倾倒垃圾。',
            '发现有人将危险废弃物（油漆桶）投入普通垃圾桶。',
            '有人长期占用投放点空间堆放私人物品。',
            '发现有人故意破坏投放点设施设备。',
            '有人将大件家具随意丢弃在投放点旁边。',
            '发现宠物粪便被错误地投入厨余垃圾桶。',
            '有人在投放点附近焚烧垃圾，存在安全隐患。',
            '发现有人多次不分类直接混合投放。',
            '投放点周边存在乱扔垃圾的不文明行为。',
        ]
        statuses = ['confirmed'] * 40 + ['pending'] * 35 + ['rejected'] * 25
        now = datetime.now()
        vr_count = 0

        for _ in range(40):
            reporter = random.choice(residents)
            suspect = random.choice(residents)
            while suspect.id == reporter.id:
                suspect = random.choice(residents)
            wp = random.choice(waste_points)

            ViolationReport.objects.create(
                reporter=reporter, user=suspect,
                waste_point=wp,
                description=random.choice(viol_descs),
                image_url='', status=random.choice(statuses),
                created_at=now - timedelta(days=random.randint(0, 90)),
            )
            vr_count += 1

        self.stdout.write(f'  已创建 {vr_count} 条违规举报')

    def _seed_faqs(self, guide_categories):
        from apps.guides.models import FAQ
        if FAQ.objects.exists():
            self.stdout.write('  常见问题已存在，跳过')
            return

        faq_data = [
            ('什么是垃圾分类？', '垃圾分类是指按照一定规定或标准将垃圾分类储存、分类投放和分类搬运，从而转变成公共资源的一系列活动的总称。', '基础概念'),
            ('为什么要进行垃圾分类？', '垃圾分类可以减少环境污染、节约土地资源、再生资源利用，是实现可持续发展的重要举措。', '基础概念'),
            ('四种垃圾分别用什么颜色的桶？', '可回收物-蓝色，厨余垃圾-绿色，有害垃圾-红色，其他垃圾-灰色或黑色。', '分类知识'),
            ('外卖餐盒属于什么垃圾？', '干净的外卖餐盒属于可回收物；沾有大量油污的建议作为其他垃圾处理。', '分类知识'),
            ('用过的纸巾可以回收吗？', '不可以。用过的纸巾已被污染且水溶性差，属于其他垃圾。', '分类知识'),
            ('过期药品应该怎么扔？', '过期药品属于有害垃圾，应连同包装一起投入红色的有害垃圾桶。', '有害垃圾'),
            ('电池都是有害垃圾吗？', '目前市面上的普通干电池（碱性电池）已实现无汞化，可作为其他垃圾投放；但充电电池、纽扣电池仍属有害垃圾。', '有害垃圾'),
            ('宠物粪便算什么垃圾？', '宠物粪便不属于生活垃圾范畴，应冲入马桶或在绿化带掩埋，不应投入任何垃圾桶。', '其他垃圾'),
            ('大件家具如何处理？', '大件家具不应投入普通垃圾桶，请联系物业预约上门回收或送往指定的大件垃圾处理点。', '其他垃圾'),
            ('积分如何获取？', '通过正确分类投放垃圾可获得积分，不同类型的垃圾分值不同。还可通过参与活动、连续签到等方式获取积分。', '积分规则'),
            ('积分可以用来做什么？', '积分可在积分商城兑换各种环保商品和服务，也可用于参与抽奖活动。', '积分规则'),
            ('投放时间是什么时候？', '各投放点的开放时间可能不同，一般为早上6:00至晚上22:00，具体请查看投放点详情。', '投放须知'),
            ('分类错了怎么办？', '如果发现分类错误，请及时联系现场工作人员协助处理，或自行重新分类后再次投放。', '投放须知'),
            ('如何查看我的投放记录？', '登录系统后在"个人中心"或"投放记录"页面可以查看历史投放记录和获得的积分详情。', '使用帮助'),
            ('忘记密码怎么办？', '可以通过注册手机号或邮箱找回密码，也可以联系物业管理员重置密码。', '使用帮助'),
        ]
        faq_count = 0
        for question, answer, category in faq_data:
            FAQ.objects.create(question=question, answer=answer, category=category)
            faq_count += 1

        self.stdout.write(f'  已创建 {faq_count} 条常见问题')
