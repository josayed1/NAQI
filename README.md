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

    /* Language Dropdown */
    .lang-dropdown {
      position: relative;
      display: inline-block;
    }

    .lang-menu {
      display: none;
      position: absolute;
      background-color: white;
      min-width: 160px;
      box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
      border-radius: 8px;
      z-index: 1;
      top: 45px;
      left: 0;
    }

    body.dark-mode .lang-menu {
      background-color: #1a1f3a;
    }

    .lang-menu a {
      color: var(--text);
      padding: 12px 16px;
      text-decoration: none;
      display: block;
      border-radius: 8px;
    }

    body.dark-mode .lang-menu a {
      color: #e8eaed;
    }

    .lang-menu a:hover {
      background-color: rgba(0, 119, 182, 0.1);
    }

    .lang-dropdown.active .lang-menu {
      display: block;
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
      cursor: pointer;
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
      cursor: pointer;
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

    /* Interactive Demo Section */
    .demo-container {
      margin-top: 30px;
      padding: 20px;
      background: rgba(0, 119, 182, 0.05);
      border-radius: 15px;
      text-align: center;
    }

    body.dark-mode .demo-container {
      background: rgba(0, 119, 182, 0.1);
    }

    .demo-controls {
      display: flex;
      justify-content: center;
      gap: 15px;
      margin-top: 20px;
      flex-wrap: wrap;
    }

    .demo-btn {
      background: linear-gradient(135deg, var(--secondary) 0%, var(--primary) 100%);
      color: #fff;
      border: none;
      padding: 10px 20px;
      border-radius: 30px;
      font-size: 16px;
      cursor: pointer;
      transition: all 0.3s ease;
    }

    .demo-btn:hover {
      transform: translateY(-3px);
      box-shadow: 0 5px 15px rgba(0, 119, 182, 0.3);
    }

    .demo-result {
      margin-top: 20px;
      padding: 15px;
      border-radius: 10px;
      background: rgba(255, 255, 255, 0.7);
      min-height: 100px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 18px;
      transition: all 0.3s ease;
    }

    body.dark-mode .demo-result {
      background: rgba(26, 31, 58, 0.7);
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

    /* Notification */
    .notification {
      position: fixed;
      bottom: 20px;
      left: 20px;
      background: var(--primary);
      color: white;
      padding: 15px 25px;
      border-radius: 10px;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
      transform: translateY(100px);
      opacity: 0;
      transition: all 0.3s ease;
      z-index: 1001;
      max-width: 300px;
    }

    .notification.show {
      transform: translateY(0);
      opacity: 1;
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
        <span data-ar="نقي – NAQI" data-en="NAQI" data-fr="NAQI" data-es="NAQI" data-de="NAQI">نقي – NAQI</span>
      </div>
      <div class="nav-controls">
        <div class="lang-dropdown" id="langDropdown">
          <button class="nav-btn" id="langToggle" title="تغيير اللغة">
            <i class="fas fa-language"></i>
          </button>
          <div class="lang-menu">
            <a href="#" data-lang="ar">العربية</a>
            <a href="#" data-lang="en">English</a>
            <a href="#" data-lang="fr">Français</a>
            <a href="#" data-lang="es">Español</a>
            <a href="#" data-lang="de">Deutsch</a>
          </div>
        </div>
        <button class="nav-btn" id="modeToggle" title="الوضع الليلي">
          <i class="fas fa-moon"></i>
        </button>
      </div>
    </div>
  </nav>

  <!-- Header -->
  <header>
    <span data-ar="تطبيق نقي – نقاء الاستخدام اليومي" data-en="NAQI App - Daily Purity of Use" data-fr="Application NAQI - Pureté Quotidienne" data-es="Aplicación NAQI - Pureza Diaria" data-de="NAQI App - Tägliche Reinheit">تطبيق نقي – نقاء الاستخدام اليومي</span>
  </header>

  <!-- Introduction Section -->
  <section>
    <h2 data-ar="📱 تعريف التطبيق" data-en="📱 App Introduction" data-fr="📱 Introduction de l'application" data-es="📱 Introducción de la aplicación" data-de="📱 App-Einführung">📱 تعريف التطبيق</h2>
    <p data-ar="تطبيق <strong>نقي</strong> هو فكرة طلابية تهدف إلى جعل استخدام الموبايل أكثر نقاءً وهدوءًا. يعتمد التطبيق على الذكاء الاصطناعي لتصفية الصور والفيديوهات والأصوات المخالفة حسب رغبة المستخدم، وكل دا بيحصل محليًا على الهاتف بدون رفع أي بيانات على الإنترنت، حفاظًا على الخصوصية." data-en="The <strong>NAQI</strong> app is a student project aimed at making mobile usage purer and calmer. The app uses artificial intelligence to filter images, videos, and sounds that violate user preferences, all processed locally on the phone without uploading any data to the internet, ensuring privacy." data-fr="L'application <strong>NAQI</strong> est un projet étudiant visant à rendre l'utilisation du mobile plus pure et plus calme. L'application utilise l'intelligence artificielle pour filtrer les images, les vidéos et les sons qui violent les préférences de l'utilisateur, tout étant traité localement sur le téléphone sans télécharger de données sur Internet, garantissant la confidentialité." data-es="La aplicación <strong>NAQI</strong> es un proyecto estudiantil destinado a hacer que el uso del móvil sea más puro y tranquilo. La aplicación utiliza inteligencia artificial para filtrar imágenes, videos y sonidos que violan las preferencias del usuario, todo procesado localmente en el teléfono sin subir datos a Internet, garantizando la privacidad." data-de="Die <strong>NAQI</strong>-App ist ein Studentenprojekt, das darauf abzielt, die Handynutzung reiner und ruhiger zu gestalten. Die App verwendet künstliche Intelligenz, um Bilder, Videos und Töne zu filtern, die gegen die Benutzereinstellungen verstoßen, alles lokal auf dem Telefon verarbeitet, ohne Daten ins Internet hochzuladen, um die Privatsphäre zu gewährleisten.">تطبيق <strong>نقي</strong> هو فكرة طلابية تهدف إلى جعل استخدام الموبايل أكثر نقاءً وهدوءًا. يعتمد التطبيق على الذكاء الاصطناعي لتصفية الصور والفيديوهات والأصوات المخالفة حسب رغبة المستخدم، وكل دا بيحصل محليًا على الهاتف بدون رفع أي بيانات على الإنترنت، حفاظًا على الخصوصية.</p>
  </section>

  <!-- Settings Section -->
  <section>
    <h2 data-ar="⚙ الإعدادات الأساسية للتشغيل" data-en="⚙ Basic Settings for Operation" data-fr="⚙ Paramètres de base pour le fonctionnement" data-es="⚙ Configuración básica para el funcionamiento" data-de="⚙ Grundeinstellungen für den Betrieb">⚙ الإعدادات الأساسية للتشغيل</h2>
    <p data-ar="اختَر نوع المحتوى اللي تحب التطبيق يتعامل معاه حسب جنسك:" data-en="Choose the content type you want the app to handle based on your gender:" data-fr="Choisissez le type de contenu que vous souhaitez que l'application gère en fonction de votre sexe :" data-es="Elija el tipo de contenido que desea que la aplicación maneje según su género:" data-de="Wählen Sie den Inhaltstyp, den die App je nach Ihrem Geschlecht verarbeiten soll:">اختَر نوع المحتوى اللي تحب التطبيق يتعامل معاه حسب جنسك:</p>
    <div class="gender-section">
      <div class="gender-buttons">
        <button id="maleBtn">
          <i class="fas fa-mars"></i> <span data-ar="أنا ولد" data-en="I'm a boy" data-fr="Je suis un garçon" data-es="Soy un niño" data-de="Ich bin ein Junge">أنا ولد</span>
        </button>
        <button id="femaleBtn">
          <i class="fas fa-venus"></i> <span data-ar="أنا بنت" data-en="I'm a girl" data-fr="Je suis une fille" data-es="Soy una niña" data-de="Ich bin ein Mädchen">أنا بنت</span>
        </button>
      </div>
      <p id="status"></p>
    </div>
  </section>

  <!-- Interactive Demo Section -->
  <section>
    <h2 data-ar="🧪 تجربة تفاعلية" data-en="🧪 Interactive Demo" data-fr="🧪 Démo interactive" data-es="🧪 Demo interactivo" data-de="🧪 Interaktive Demo">🧪 تجربة تفاعلية</h2>
    <p data-ar="جرب كيف يعمل تطبيق نقي في فلترة المحتوى:" data-en="Try how the NAQI app works in filtering content:" data-fr="Essayez comment l'application NAQI fonctionne pour filtrer le contenu :" data-es="Pruebe cómo funciona la aplicación NAQI para filtrar contenido:" data-de="Testen Sie, wie die NAQI-App Inhalte filtert:">جرب كيف يعمل تطبيق نقي في فلترة المحتوى:</p>
    
    <div class="demo-container">
      <div class="demo-controls">
        <button class="demo-btn" id="imageBtn">
          <i class="fas fa-image"></i> <span data-ar="فلترة الصور" data-en="Filter Images" data-fr="Filtrer les images" data-es="Filtrar imágenes" data-de="Bilder filtern">فلترة الصور</span>
        </button>
        <button class="demo-btn" id="videoBtn">
          <i class="fas fa-video"></i> <span data-ar="فلترة الفيديو" data-en="Filter Videos" data-fr="Filtrer les vidéos" data-es="Filtrar videos" data-de="Videos filtern">فلترة الفيديو</span>
        </button>
        <button class="demo-btn" id="audioBtn">
          <i class="fas fa-music"></i> <span data-ar="فلترة الصوت" data-en="Filter Audio" data-fr="Filtrer l'audio" data-es="Filtrar audio" data-de="Audio filtern">فلترة الصوت</span>
        </button>
      </div>
      <div class="demo-result" id="demoResult">
        <span data-ar="اختر نوع المحتوى لتجربة الفلترة" data-en="Select content type to experience filtering" data-fr="Sélectionnez le type de contenu pour expérimenter le filtrage" data-es="Seleccione el tipo de contenido para experimentar el filtrado" data-de="Wählen Sie den Inhaltstyp aus, um das Filtern zu erleben">اختر نوع المحتوى لتجربة الفلترة</span>
      </div>
    </div>
  </section>

  <!-- Music Section -->
  <section>
    <h2 data-ar="🎵 فلترة الموسيقى" data-en="🎵 Music Filtering" data-fr="🎵 Filtrage de musique" data-es="🎵 Filtrado de música" data-de="🎵 Musikfilterung">🎵 فلترة الموسيقى</h2>
    <p data-ar="يحتوي تطبيق نقي على نظام متقدم لفلترة الموسيقى يعمل بالذكاء الاصطناعي لتحديد وإزالة الموسيقى غير الإسلامية تلقائيًا من جميع التطبيقات على هاتفك." data-en="NAQI app includes an advanced music filtering system that uses artificial intelligence to automatically detect and remove non-Islamic music from all applications on your phone." data-fr="L'application NAQI comprend un système de filtrage de musique avancé qui utilise l'intelligence artificielle pour détecter et supprimer automatiquement la musique non islamique de toutes les applications sur votre téléphone." data-es="La aplicación NAQI incluye un sistema avanzado de filtrado de música que utiliza inteligencia artificial para detectar y eliminar automáticamente la música no islámica de todas las aplicaciones en su teléfono." data-de="Die NAQI-App enthält ein erweitertes Musikfiltersystem, das künstliche Intelligenz verwendet, um nicht-islamische Musik automatisch aus allen Anwendungen auf Ihrem Telefon zu erkennen und zu entfernen.">يحتوي تطبيق نقي على نظام متقدم لفلترة الموسيقى يعمل بالذكاء الاصطناعي لتحديد وإزالة الموسيقى غير الإسلامية تلقائيًا من جميع التطبيقات على هاتفك.</p>
    
    <div class="music-features">
      <div class="music-feature" data-feature="detection">
        <i class="fas fa-music"></i>
        <h3 data-ar="كشف تلقائي" data-en="Automatic Detection" data-fr="Détection automatique" data-es="Detección automática" data-de="Automatische Erkennung">كشف تلقائي</h3>
        <p data-ar="يكتشف الموسيقى تلقائيًا أثناء التشغيل" data-en="Automatically detects music during playback" data-fr="Détecte automatiquement la musique pendant la lecture" data-es="Detecta automáticamente la música durante la reproducción" data-de="Erkennt Musik automatisch während der Wiedergabe">يكتشف الموسيقى تلقائيًا أثناء التشغيل</p>
      </div>
      <div class="music-feature" data-feature="removal">
        <i class="fas fa-volume-mute"></i>
        <h3 data-ar="إزالة فورية" data-en="Instant Removal" data-fr="Retrait instantané" data-es="Eliminación instantánea" data-de="Sofortige Entfernung">إزالة فورية</h3>
        <p data-ar="يوقف الموسيقى غير المرغوب فيها فورًا" data-en="Stops unwanted music instantly" data-fr="Arrête instantanément la musique indésirable" data-es="Detiene la música no deseada al instante" data-de="Stoppt unerwünschte Musik sofort">يوقف الموسيقى غير المرغوب فيها فورًا</p>
      </div>
      <div class="music-feature" data-feature="privacy">
        <i class="fas fa-shield-alt"></i>
        <h3 data-ar="خصوصية تامة" data-en="Complete Privacy" data-fr="Confidentialité complète" data-es="Privacidad completa" data-de="Vollständige Privatsphäre">خصوصية تامة</h3>
        <p data-ar="التحليل يتم محليًا دون إرسال بيانات" data-en="Analysis is done locally without sending data" data-fr="L'analyse est effectuée localement sans envoyer de données" data-es="El análisis se realiza localmente sin enviar datos" data-de="Die Analyse erfolgt lokal ohne Senden von Daten">التحليل يتم محليًا دون إرسال بيانات</p>
      </div>
    </div>
  </section>

  <!-- Team Section -->
  <section>
    <h2 data-ar="👥 الفريق" data-en="👥 Team" data-fr="👥 Équipe" data-es="👥 Equipo" data-de="👥 Team">👥 الفريق</h2>
    <div class="team">
      <div class="member" data-member="yusuf">
        <h3 data-ar="يوسف سيد" data-en="Yusuf Sayyid" data-fr="Yusuf Sayyid" data-es="Yusuf Sayyid" data-de="Yusuf Sayyid">يوسف سيد</h3>
      </div>
      <div class="member" data-member="anas">
        <h3 data-ar="أنس ناجي" data-en="Anas Najy" data-fr="Anas Najy" data-es="Anas Najy" data-de="Anas Najy">أنس ناجي</h3>
      </div>
    </div>
  </section>

  <!-- Footer -->
  <footer>
    <span data-ar="© 2025 تطبيق نقي – جميع الحقوق محفوظة." data-en="© 2025 NAQI App - All rights reserved." data-fr="© 2025 Application NAQI - Tous droits réservés." data-es="© 2025 Aplicación NAQI - Todos los derechos reservados." data-de="© 2025 NAQI App - Alle Rechte vorbehalten.">© 2025 تطبيق نقي – جميع الحقوق محفوظة.</span>
  </footer>

  <!-- Notification -->
  <div class="notification" id="notification"></div>

  <script>
    // Language Toggle
    const langToggle = document.getElementById('langToggle');
    const langDropdown = document.getElementById('langDropdown');
    const html = document.documentElement;
    let currentLang = 'ar';
    
    langToggle.addEventListener('click', () => {
      langDropdown.classList.toggle('active');
    });
    
    // Close dropdown when clicking outside
    document.addEventListener('click', (e) => {
      if (!langDropdown.contains(e.target)) {
        langDropdown.classList.remove('active');
      }
    });
    
    // Handle language selection
    const langLinks = document.querySelectorAll('.lang-menu a');
    langLinks.forEach(link => {
      link.addEventListener('click', (e) => {
        e.preventDefault();
        const lang = link.getAttribute('data-lang');
        changeLanguage(lang);
        langDropdown.classList.remove('active');
      });
    });
    
    function changeLanguage(lang) {
      currentLang = lang;
      html.setAttribute('lang', lang);
      
      // Change direction for RTL languages
      if (lang === 'ar') {
        html.setAttribute('dir', 'rtl');
      } else {
        html.setAttribute('dir', 'ltr');
      }
      
      // Update all text elements
      const elements = document.querySelectorAll('[data-' + lang + ']');
      elements.forEach(element => {
        element.textContent = element.getAttribute('data-' + lang);
      });
      
      // Show notification
      showNotification(getTranslation('notification_lang_changed', lang));
    }
    
    function getTranslation(key, lang) {
      const translations = {
        notification_lang_changed: {
          ar: 'تم تغيير اللغة بنجاح',
          en: 'Language changed successfully',
          fr: 'Langue changée avec succès',
          es: 'Idioma cambiado correctamente',
          de: 'Sprache erfolgreich geändert'
        },
        gender_selected: {
          ar: 'تم اختيار الجنس بنجاح',
          en: 'Gender selected successfully',
          fr: 'Sexe sélectionné avec succès',
          es: 'Género seleccionado correctamente',
          de: 'Geschlecht erfolgreich ausgewählt'
        },
        demo_filtering: {
          ar: 'جاري فلترة المحتوى...',
          en: 'Filtering content...',
          fr: 'Filtrage du contenu...',
          es: 'Filtrando contenido...',
          de: 'Inhalt wird gefiltert...'
        },
        demo_completed: {
          ar: 'تمت فلترة المحتوى بنجاح',
          en: 'Content filtered successfully',
          fr: 'Contenu filtré avec succès',
          es: 'Contenido filtrado correctamente',
          de: 'Inhalt erfolgreich gefiltert'
        },
        feature_info: {
          ar: 'ميزة: ',
          en: 'Feature: ',
          fr: 'Fonctionnalité: ',
          es: 'Característica: ',
          de: 'Funktion: '
        },
        team_member: {
          ar: 'عضو الفريق: ',
          en: 'Team Member: ',
          fr: 'Membre de l\'équipe: ',
          es: 'Miembro del equipo: ',
          de: 'Teammitglied: '
        }
      };
      
      return translations[key][lang] || key;
    }
    
    // Dark Mode Toggle
    const modeToggle = document.getElementById('modeToggle');
    const body = document.body;
    const icon = modeToggle.querySelector('i');
    
    // Check for saved dark mode preference or respect OS preference
    if (localStorage.getItem('darkMode') === 'true' || 
        (!localStorage.getItem('darkMode') && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
      body.classList.add('dark-mode');
      icon.classList.remove('fa-moon');
      icon.classList.add('fa-sun');
    }
    
    modeToggle.addEventListener('click', () => {
      body.classList.toggle('dark-mode');
      const isDarkMode = body.classList.contains('dark-mode');
      
      if (isDarkMode) {
        icon.classList.remove('fa-moon');
        icon.classList.add('fa-sun');
        localStorage.setItem('darkMode', 'true');
      } else {
        icon.classList.remove('fa-sun');
        icon.classList.add('fa-moon');
        localStorage.setItem('darkMode', 'false');
      }
    });
    
    // Gender Selection
    const maleBtn = document.getElementById("maleBtn");
    const femaleBtn = document.getElementById("femaleBtn");
    const status = document.getElementById("status");
    
    maleBtn.addEventListener("click", () => {
      maleBtn.classList.add("selected");
      femaleBtn.classList.remove("selected");
      status.textContent = currentLang === 'ar' ? "تم اختيار: ولد 👦" : 
                          currentLang === 'fr' ? "Sélectionné: Garçon 👦" :
                          currentLang === 'es' ? "Seleccionado: Niño 👦" :
                          currentLang === 'de' ? "Ausgewählt: Junge 👦" :
                          "Selected: Boy 👦";
      
      // Save preference
      localStorage.setItem('gender', 'male');
      
      // Show notification
      showNotification(getTranslation('gender_selected', currentLang));
    });
    
    femaleBtn.addEventListener("click", () => {
      femaleBtn.classList.add("selected");
      maleBtn.classList.remove("selected");
      status.textContent = currentLang === 'ar' ? "تم اختيار: بنت 👧" : 
                          currentLang === 'fr' ? "Sélectionné: Fille 👧" :
                          currentLang === 'es' ? "Seleccionado: Niña 👧" :
                          currentLang === 'de' ? "Ausgewählt: Mädchen 👧" :
                          "Selected: Girl 👧";
      
      // Save preference
      localStorage.setItem('gender', 'female');
      
      // Show notification
      showNotification(getTranslation('gender_selected', currentLang));
    });
    
    // Check for saved gender preference
    const savedGender = localStorage.getItem('gender');
    if (savedGender === 'male') {
      maleBtn.click();
    } else if (savedGender === 'female') {
      femaleBtn.click();
    }
    
    // Interactive Demo
    const imageBtn = document.getElementById('imageBtn');
    const videoBtn = document.getElementById('videoBtn');
    const audioBtn = document.getElementById('audioBtn');
    const demoResult = document.getElementById('demoResult');
    
    imageBtn.addEventListener('click', () => {
      runDemo('image');
    });
    
    videoBtn.addEventListener('click', () => {
      runDemo('video');
    });
    
    audioBtn.addEventListener('click', () => {
      runDemo('audio');
    });
    
    function runDemo(type) {
      // Show processing message
      demoResult.innerHTML = <i class="fas fa-spinner fa-spin"></i> ${getTranslation('demo_filtering', currentLang)};
      
      // Simulate processing time
      setTimeout(() => {
        let icon, message;
        
        switch(type) {
          case 'image':
            icon = 'fa-image';
            message = currentLang === 'ar' ? 'تمت فلترة الصور غير المناسبة' :
                     currentLang === 'fr' ? 'Images inappropriées filtrées' :
                     currentLang === 'es' ? 'Imágenes inapropiadas filtradas' :
                     currentLang === 'de' ? 'Ungeeignete Bilder gefiltert' :
                     'Inappropriate images filtered';
            break;
          case 'video':
            icon = 'fa-video';
            message = currentLang === 'ar' ? 'تمت فلترة الفيديوهات غير المناسبة' :
                     currentLang === 'fr' ? 'Vidéos inappropriées filtrées' :
                     currentLang === 'es' ? 'Videos inapropiados filtrados' :
                     currentLang === 'de' ? 'Ungeeignete Videos gefiltert' :
                     'Inappropriate videos filtered';
            break;
          case 'audio':
            icon = 'fa-music';
            message = currentLang === 'ar' ? 'تمت فلترة الأصوات غير المناسبة' :
                     currentLang === 'fr' ? 'Sons inappropriés filtrés' :
                     currentLang === 'es' ? 'Sonidos inapropiados filtrados' :
                     currentLang === 'de' ? 'Ungeeignete Töne gefiltert' :
                     'Inappropriate sounds filtered';
            break;
        }
        
        demoResult.innerHTML = <i class="fas ${icon}"></i> ${message};
        
        // Show notification
        showNotification(getTranslation('demo_completed', currentLang));
      }, 2000);
    }
    
    // Music Feature Interaction
    const musicFeatures = document.querySelectorAll('.music-feature');
    musicFeatures.forEach(feature => {
      feature.addEventListener('click', () => {
        const featureType = feature.getAttribute('data-feature');
        let featureName;
        
        switch(featureType) {
          case 'detection':
            featureName = currentLang === 'ar' ? 'الكشف التلقائي' :
                         currentLang === 'fr' ? 'Détection automatique' :
                         currentLang === 'es' ? 'Detección automática' :
                         currentLang === 'de' ? 'Automatische Erkennung' :
                         'Automatic Detection';
            break;
          case 'removal':
            featureName = currentLang === 'ar' ? 'الإزالة الفورية' :
                         currentLang === 'fr' ? 'Retrait instantané' :
                         currentLang === 'es' ? 'Eliminación instantánea' :
                         currentLang === 'de' ? 'Sofortige Entfernung' :
                         'Instant Removal';
            break;
          case 'privacy':
            featureName = currentLang === 'ar' ? 'الخصوصية التامة' :
                         currentLang === 'fr' ? 'Confidentialité complète' :
                         currentLang === 'es' ? 'Privacidad completa' :
                         currentLang === 'de' ? 'Vollständige Privatsphäre' :
                         'Complete Privacy';
            break;
        }
        
        showNotification(getTranslation('feature_info', currentLang) + featureName);
      });
    });
    
    // Team Member Interaction
    const teamMembers = document.querySelectorAll('.member');
    teamMembers.forEach(member => {
      member.addEventListener('click', () => {
        const memberType = member.getAttribute('data-member');
        let memberName;
        
        switch(memberType) {
          case 'yusuf':
            memberName = currentLang === 'ar' ? 'يوسف سيد' :
                         currentLang === 'fr' ? 'Yusuf Sayyid' :
                         currentLang === 'es' ? 'Yusuf Sayyid' :
                         currentLang === 'de' ? 'Yusuf Sayyid' :
                         'Yusuf Sayyid';
            break;
          case 'anas':
            memberName = currentLang === 'ar' ? 'أنس ناجي' :
                         currentLang === 'fr' ? 'Anas Najy' :
                         currentLang === 'es' ? 'Anas Najy' :
                         currentLang === 'de' ? 'Anas Najy' :
                         'Anas Najy';
            break;
        }
        
        showNotification(getTranslation('team_member', currentLang) + memberName);
      });
    });
    
    // Notification System
    function showNotification(message) {
      const notification = document.getElementById('notification');
      notification.textContent = message;
      notification.classList.add('show');
      
      setTimeout(() => {
        notification.classList.remove('show');
      }, 3000);
    }
    
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
    
    // Add some interactive animations on page load
    window.addEventListener('load', () => {
      const sections = document.querySelectorAll('section');
      sections.forEach((section, index) => {
        setTimeout(() => {
          section.style.opacity = '0';
          section.style.transform = 'translateY(20px)';
          section.style.transition = 'all 0.5s ease';
          
          setTimeout(() => {
            section.style.opacity = '1';
            section.style.transform = 'translateY(0)';
          }, 100);
        }, index * 200);
      });
    });
  </script>

</body>
</html>
