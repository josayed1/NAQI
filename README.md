<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>نقي - NAQI | تطبيق التصفية الأخلاقية</title>
  
  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@300;400;600;700;900&display=swap" rel="stylesheet">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  
  <style>
    :root {
      --primary: #0077b6;
      --secondary: #00b4d8;
      --accent: #00f5ff;
      --light: #f7f9fc;
      --dark: #0a0e27;
      --text: #222;
      --card-bg: #ffffff;
      --shadow: rgba(0, 119, 182, 0.15);
    }

    body {
      font-family: "Cairo", sans-serif;
      background: linear-gradient(135deg, #f7f9fc 0%, #dfe9f3 100%);
      margin: 0;
      color: var(--text);
      transition: all 0.3s ease;
      position: relative;
      overflow-x: hidden;
    }

    body.dark-mode {
      background: linear-gradient(135deg, #0a0e27 0%, #1a1f3a 100%);
      color: #e8eaed;
    }

    body.dark-mode section {
      background: rgba(26, 31, 58, 0.9);
      color: #e8eaed;
    }

    body.dark-mode .member {
      background: rgba(0, 119, 182, 0.1);
    }

    body.dark-mode h2 {
      color: var(--accent);
    }

    body.dark-mode button {
      background: var(--secondary);
    }

    body.dark-mode button:hover {
      background: var(--primary);
    }

    body.dark-mode footer {
      color: #aaa;
    }

    /* Navigation */
    nav {
      position: fixed;
      top: 0;
      width: 100%;
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(10px);
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
      z-index: 1000;
      transition: all 0.3s ease;
    }

    body.dark-mode nav {
      background: rgba(26, 31, 58, 0.95);
    }

    .nav-container {
      max-width: 1200px;
      margin: 0 auto;
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 15px 20px;
    }

    .nav-brand {
      font-size: 24px;
      font-weight: 700;
      color: var(--primary);
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .nav-controls {
      display: flex;
      gap: 15px;
    }

    .nav-btn {
      background: none;
      border: none;
      font-size: 20px;
      color: var(--primary);
      cursor: pointer;
      transition: all 0.3s ease;
      padding: 8px;
      border-radius: 50%;
      width: 40px;
      height: 40px;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .nav-btn:hover {
      background: rgba(0, 119, 182, 0.1);
      transform: scale(1.1);
    }

    /* Header */
    header {
      background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
      color: #fff;
      text-align: center;
      padding: 100px 10px 50px;
      font-size: 32px;
      font-weight: 900;
      letter-spacing: 1px;
      position: relative;
      overflow: hidden;
      margin-top: 70px;
    }

    header::before {
      content: '';
      position: absolute;
      top: -50%;
      left: -50%;
      width: 200%;
      height: 200%;
      background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
      animation: pulse 4s ease-in-out infinite;
    }

    @keyframes pulse {
      0%, 100% { transform: scale(1); opacity: 0.5; }
      50% { transform: scale(1.1); opacity: 0.3; }
    }

    /* Sections */
    section {
      max-width: 900px;
      margin: 40px auto;
      background: var(--card-bg);
      border-radius: 20px;
      box-shadow: 0 10px 30px var(--shadow);
      padding: 30px;
      position: relative;
      overflow: hidden;
      transition: all 0.3s ease;
    }

    section::before {
      content: '';
      position: absolute;
      top: -50px;
      right: -50px;
      width: 100px;
      height: 100px;
      background: linear-gradient(45deg, var(--primary), var(--secondary));
      border-radius: 50%;
      opacity: 0.1;
      animation: float 10s ease-in-out infinite;
    }

    @keyframes float {
      0%, 100% { transform: translateY(0) rotate(0deg); }
      50% { transform: translateY(-20px) rotate(10deg); }
    }

    section:hover {
      transform: translateY(-5px);
      box-shadow: 0 15px 40px var(--shadow);
    }

    h2 {
      color: var(--primary);
      border-right: 5px solid var(--secondary);
      padding-right: 15px;
      font-size: 28px;
      font-weight: 700;
      margin-bottom: 20px;
      position: relative;
    }

    body[dir="ltr"] h2 {
      border-right: none;
      border-left: 5px solid var(--secondary);
      padding-right: 0;
      padding-left: 15px;
    }

    p {
      line-height: 1.9;
      font-size: 18px;
      margin-bottom: 20px;
    }

    /* Gender Section */
    .gender-section {
      text-align: center;
      margin-top: 30px;
      position: relative;
    }

    .gender-buttons {
      display: flex;
      justify-content: center;
      gap: 20px;
      flex-wrap: wrap;
      margin-bottom: 20px;
    }

    button {
      background: linear-gradient(135deg, var(--secondary) 0%, var(--primary) 100%);
      color: #fff;
      border: none;
      padding: 15px 30px;
      border-radius: 50px;
      font-size: 18px;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.3s ease;
      box-shadow: 0 5px 15px rgba(0, 180, 216, 0.3);
      position: relative;
      overflow: hidden;
    }

    button::before {
      content: '';
      position: absolute;
      top: 50%;
      left: 50%;
      width: 0;
      height: 0;
      background: rgba(255, 255, 255, 0.3);
      border-radius: 50%;
      transform: translate(-50%, -50%);
      transition: width 0.6s, height 0.6s;
    }

    button:hover::before {
      width: 300px;
      height: 300px;
    }

    button:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 25px rgba(0, 180, 216, 0.4);
    }

    .selected {
      background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%) !important;
      transform: scale(1.05);
      box-shadow: 0 8px 20px rgba(0, 119, 182, 0.5) !important;
    }

    #status {
      text-align: center;
      font-weight: bold;
      color: var(--primary);
      margin-top: 20px;
      font-size: 20px;
      padding: 10px;
      border-radius: 10px;
      background: rgba(0, 119, 182, 0.1);
      transition: all 0.3s ease;
    }

    body.dark-mode #status {
      color: var(--accent);
      background: rgba(0, 245, 255, 0.1);
    }

    /* Music Section */
    .music-features {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
      gap: 20px;
      margin-top: 25px;
    }

    .music-feature {
      background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
      padding: 20px;
      border-radius: 15px;
      text-align: center;
      transition: all 0.3s ease;
    }

    body.dark-mode .music-feature {
      background: rgba(0, 119, 182, 0.1);
    }

    .music-feature:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 20px rgba(0, 119, 182, 0.2);
    }

    .music-feature i {
      font-size: 2.5rem;
      color: var(--primary);
      margin-bottom: 15px;
    }

    .music-feature h3 {
      color: var(--primary);
      margin-bottom: 10px;
      font-size: 1.2rem;
    }

    /* Team Section */
    .team {
      display: flex;
      justify-content: center;
      gap: 30px;
      flex-wrap: wrap;
      margin-top: 30px;
    }

    .member {
      background: linear-gradient(135deg, #f1f9ff 0%, #e6f4ff 100%);
      padding: 25px;
      border-radius: 20px;
      box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
      text-align: center;
      width: 250px;
      transition: all 0.3s ease;
      position: relative;
      overflow: hidden;
    }

    .member::before {
      content: '';
      position: absolute;
      top: -50%;
      left: -50%;
      width: 200%;
      height: 200%;
      background: linear-gradient(45deg, transparent, rgba(0, 119, 182, 0.1), transparent);
      transform: rotate(45deg);
      transition: all 0.5s;
    }

    .member:hover::before {
      left: 100%;
    }

    .member:hover {
      transform: translateY(-10px) rotateX(5deg);
      box-shadow: 0 15px 35px rgba(0, 119, 182, 0.2);
    }

    .member h3 {
      color: var(--primary);
      margin-bottom: 10px;
      font-size: 24px;
      font-weight: 700;
      position: relative;
      z-index: 1;
    }

    /* Footer */
    footer {
      text-align: center;
      padding: 30px 20px;
      color: #777;
      font-size: 16px;
      background: rgba(255, 255, 255, 0.5);
      backdrop-filter: blur(10px);
      margin-top: 50px;
    }

    body.dark-mode footer {
      background: rgba(26, 31, 58, 0.5);
    }

    /* Floating 3D Shapes */
    .floating-shapes {
      position: fixed;
      width: 100%;
      height: 100%;
      top: 0;
      left: 0;
      pointer-events: none;
      z-index: -1;
    }

    .shape {
      position: absolute;
      opacity: 0.1;
      animation: float3d 20s infinite linear;
    }

    @keyframes float3d {
      0% { transform: translateY(0) rotateX(0) rotateY(0) rotateZ(0); }
      100% { transform: translateY(-100vh) rotateX(360deg) rotateY(360deg) rotateZ(360deg); }
    }

    /* Responsive */
    @media (max-width: 768px) {
      header {
        font-size: 24px;
        padding: 80px 10px 40px;
      }

      section {
        margin: 30px 20px;
        padding: 20px;
      }

      h2 {
        font-size: 22px;
      }

      p {
        font-size: 16px;
      }

      .member {
        width: 100%;
        max-width: 300px;
      }

      .gender-buttons {
        flex-direction: column;
        align-items: center;
      }

      button {
        width: 200px;
      }
    }
  </style>
</head>
<body>

  <!-- Floating 3D Shapes -->
  <div class="floating-shapes">
    <div class="shape" style="top: 10%; left: 5%; width: 80px; height: 80px; background: linear-gradient(45deg, #0077b6, #00b4d8); border-radius: 30%; animation-delay: 0s;"></div>
    <div class="shape" style="top: 20%; right: 10%; width: 60px; height: 60px; background: linear-gradient(45deg, #00b4d8, #00f5ff); border-radius: 50%; animation-delay: 2s;"></div>
    <div class="shape" style="top: 60%; left: 8%; width: 100px; height: 100px; background: linear-gradient(45deg, #0077b6, #00f5ff); border-radius: 20%; animation-delay: 5s;"></div>
    <div class="shape" style="top: 70%; right: 15%; width: 70px; height: 70px; background: linear-gradient(45deg, #00b4d8, #0077b6); border-radius: 40%; animation-delay: 7s;"></div>
    <div class="shape" style="top: 40%; left: 50%; width: 90px; height: 90px; background: linear-gradient(45deg, #00f5ff, #00b4d8); border-radius: 35%; animation-delay: 10s;"></div>
  </div>

  <!-- Navigation -->
  <nav>
    <div class="nav-container">
      <div class="nav-brand">
        <i class="fas fa-shield-alt"></i>
        <span>نقي – NAQI</span>
      </div>
      <div class="nav-controls">
        <button class="nav-btn" id="langToggle" title="تغيير اللغة">
          <i class="fas fa-language"></i>
        </button>
        <button class="nav-btn" id="modeToggle" title="الوضع الليلي">
          <i class="fas fa-moon"></i>
        </button>
      </div>
    </div>
  </nav>

  <!-- Header -->
  <header>
    <span data-ar="تطبيق نقي – نقاء الاستخدام اليومي" data-en="NAQI App - Daily Purity of Use">تطبيق نقي – نقاء الاستخدام اليومي</span>
  </header>

  <!-- Introduction Section -->
  <section>
    <h2 data-ar="📱 تعريف التطبيق" data-en="📱 App Introduction">📱 تعريف التطبيق</h2>
    <p data-ar="تطبيق <strong>نقي</strong> هو فكرة طلابية تهدف إلى جعل استخدام الموبايل أكثر نقاءً وهدوءًا. يعتمد التطبيق على الذكاء الاصطناعي لتصفية الصور والفيديوهات والأصوات المخالفة حسب رغبة المستخدم، وكل دا بيحصل محليًا على الهاتف بدون رفع أي بيانات على الإنترنت، حفاظًا على الخصوصية." data-en="The <strong>NAQI</strong> app is a student project aimed at making mobile usage purer and calmer. The app uses artificial intelligence to filter images, videos, and sounds that violate user preferences, all processed locally on the phone without uploading any data to the internet, ensuring privacy.">تطبيق <strong>نقي</strong> هو فكرة طلابية تهدف إلى جعل استخدام الموبايل أكثر نقاءً وهدوءًا. يعتمد التطبيق على الذكاء الاصطناعي لتصفية الصور والفيديوهات والأصوات المخالفة حسب رغبة المستخدم، وكل دا بيحصل محليًا على الهاتف بدون رفع أي بيانات على الإنترنت، حفاظًا على الخصوصية.</p>
  </section>

  <!-- Settings Section -->
  <section>
    <h2 data-ar="⚙ الإعدادات الأساسية للتشغيل" data-en="⚙ Basic Settings for Operation">⚙ الإعدادات الأساسية للتشغيل</h2>
    <p data-ar="اختَر نوع المحتوى اللي تحب التطبيق يتعامل معاه حسب جنسك:" data-en="Choose the content type you want the app to handle based on your gender:">اختَر نوع المحتوى اللي تحب التطبيق يتعامل معاه حسب جنسك:</p>
    <div class="gender-section">
      <div class="gender-buttons">
        <button id="maleBtn">
          <i class="fas fa-mars"></i> <span data-ar="أنا ولد" data-en="I'm a boy">أنا ولد</span>
        </button>
        <button id="femaleBtn">
          <i class="fas fa-venus"></i> <span data-ar="أنا بنت" data-en="I'm a girl">أنا بنت</span>
        </button>
      </div>
      <p id="status"></p>
    </div>
  </section>

  <!-- Music Section -->
  <section>
    <h2 data-ar="🎵 فلترة الموسيقى" data-en="🎵 Music Filtering">🎵 فلترة الموسيقى</h2>
    <p data-ar="يحتوي تطبيق نقي على نظام متقدم لفلترة الموسيقى يعمل بالذكاء الاصطناعي لتحديد وإزالة الموسيقى غير الإسلامية تلقائيًا من جميع التطبيقات على هاتفك." data-en="NAQI app includes an advanced music filtering system that uses artificial intelligence to automatically detect and remove non-Islamic music from all applications on your phone.">يحتوي تطبيق نقي على نظام متقدم لفلترة الموسيقى يعمل بالذكاء الاصطناعي لتحديد وإزالة الموسيقى غير الإسلامية تلقائيًا من جميع التطبيقات على هاتفك.</p>
    
    <div class="music-features">
      <div class="music-feature">
        <i class="fas fa-music"></i>
        <h3 data-ar="كشف تلقائي" data-en="Automatic Detection">كشف تلقائي</h3>
        <p data-ar="يكتشف الموسيقى تلقائيًا أثناء التشغيل" data-en="Automatically detects music during playback">يكتشف الموسيقى تلقائيًا أثناء التشغيل</p>
      </div>
      <div class="music-feature">
        <i class="fas fa-volume-mute"></i>
        <h3 data-ar="إزالة فورية" data-en="Instant Removal">إزالة فورية</h3>
        <p data-ar="يوقف الموسيقى غير المرغوب فيها فورًا" data-en="Stops unwanted music instantly">يوقف الموسيقى غير المرغوب فيها فورًا</p>
      </div>
      <div class="music-feature">
        <i class="fas fa-shield-alt"></i>
        <h3 data-ar="خصوصية تامة" data-en="Complete Privacy">خصوصية تامة</h3>
        <p data-ar="التحليل يتم محليًا دون إرسال بيانات" data-en="Analysis is done locally without sending data">التحليل يتم محليًا دون إرسال بيانات</p>
      </div>
    </div>
  </section>

  <!-- Team Section -->
  <section>
    <h2 data-ar="👥 الفريق" data-en="👥 Team">👥 الفريق</h2>
    <div class="team">
      <div class="member">
        <h3 data-ar="يوسف سيد" data-en="Yusuf Sayyid">يوسف سيد</h3>
      </div>
      <div class="member">
        <h3 data-ar="أنس ناجي" data-en="Anas Najy">أنس ناجي</h3>
      </div>
    </div>
  </section>

  <!-- Footer -->
  <footer>
    <span data-ar="© 2025 تطبيق نقي – جميع الحقوق محفوظة." data-en="© 2025 NAQI App - All rights reserved.">© 2025 تطبيق نقي – جميع الحقوق محفوظة.</span>
  </footer>

  <script>
    // Language Toggle
    const langToggle = document.getElementById('langToggle');
    const html = document.documentElement;
    let currentLang = 'ar';
    
    langToggle.addEventListener('click', () => {
      if (currentLang === 'ar') {
        html.setAttribute('lang', 'en');
        html.setAttribute('dir', 'ltr');
        currentLang = 'en';
        updateText('en');
      } else {
        html.setAttribute('lang', 'ar');
        html.setAttribute('dir', 'rtl');
        currentLang = 'ar';
        updateText('ar');
      }
    });
    
    function updateText(lang) {
      const elements = document.querySelectorAll('[data-ar][data-en]');
      elements.forEach(element => {
        element.textContent = element.getAttribute(data-${lang});
      });
    }
    
    // Dark Mode Toggle
    const modeToggle = document.getElementById('modeToggle');
    const body = document.body;
    const icon = modeToggle.querySelector('i');
    
    modeToggle.addEventListener('click', () => {
      body.classList.toggle('dark-mode');
      if (body.classList.contains('dark-mode')) {
        icon.classList.remove('fa-moon');
        icon.classList.add('fa-sun');
      } else {
        icon.classList.remove('fa-sun');
        icon.classList.add('fa-moon');
      }
    });
    
    // Gender Selection
    const maleBtn = document.getElementById("maleBtn");
    const femaleBtn = document.getElementById("femaleBtn");
    const status = document.getElementById("status");
    
    maleBtn.addEventListener("click", () => {
      maleBtn.classList.add("selected");
      femaleBtn.classList.remove("selected");
      status.textContent = currentLang === 'ar' ? "تم اختيار: ولد 👦" : "Selected: Boy 👦";
      // Here you can add code to connect to server or API to save the setting
    });
    
    femaleBtn.addEventListener("click", () => {
      femaleBtn.classList.add("selected");
      maleBtn.classList.remove("selected");
      status.textContent = currentLang === 'ar' ? "تم اختيار: بنت 👧" : "Selected: Girl 👧";
      // Here you can add code to connect to server or API to save the setting
    });
    
    // Smooth scrolling for any anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
      anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
          window.scrollTo({
            top: target.offsetTop - 80,
            behavior: 'smooth'
          });
        }
      });
    });
  </script>

</body>
</html>
