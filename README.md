
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Naqi - Content Filter</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div class="container">
        <header>
            <div class="logo-container">
                <div class="logo">Naqi</div>
                <div class="tagline" data-en="Smart Content Filtering" data-ar="تصفية المحتوى الذكية">Smart Content Filtering</div>
            </div>
            <div class="header-controls">
                <button id="lang-toggle" class="btn btn-icon" title="Toggle Language">
                    <i class="fas fa-language"></i>
                </button>
                <button id="theme-toggle" class="btn btn-icon" title="Toggle Theme">
                    <i class="fas fa-moon"></i>
                </button>
            </div>
        </header>

        <main>
            <section class="hero">
                <h1 data-en="Welcome to Naqi" data-ar="مرحبًا بك في نقي">Welcome to Naqi</h1>
                <p data-en="Automatically filter unwanted content across the web" data-ar="قم بتصفية المحتوى غير المرغوب فيه تلقائيًا عبر الويب">Automatically filter unwanted content across the web</p>
            </section>

            <section class="features">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-user-shield"></i>
                    </div>
                    <h3 data-en="Gender Filtering" data-ar="تصفية حسب الجنس">Gender Filtering</h3>
                    <p data-en="Automatically detect and blur faces by gender preference" data-ar="اكتشف وقم بتعتيم الوجوه تلقائيًا حسب تفضيل الجنس">Automatically detect and blur faces by gender preference</p>
                    <div class="filter-options">
                        <label class="checkbox-container">
                            <input type="checkbox" id="filter-male">
                            <span class="checkmark"></span>
                            <span data-en="Filter Male" data-ar="تصفية الذكور">Filter Male</span>
                        </label>
                        <label class="checkbox-container">
                            <input type="checkbox" id="filter-female">
                            <span class="checkmark"></span>
                            <span data-en="Filter Female" data-ar="تصفية الإناث">Filter Female</span>
                        </label>
                    </div>
                    <div class="filter-style">
                        <label data-en="Filter Style:" data-ar="نمط التصفية:">Filter Style:</label>
                        <div class="radio-group">
                            <label class="radio-container">
                                <input type="radio" name="filter-style" value="blur" checked>
                                <span class="radiomark"></span>
                                <span data-en="Blur" data-ar="تعتيم">Blur</span>
                            </label>
                            <label class="radio-container">
                                <input type="radio" name="filter-style" value="black">
                                <span class="radiomark"></span>
                                <span data-en="Black Overlay" data-ar="غطاء أسود">Black Overlay</span>
                            </label>
                        </div>
                    </div>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-music"></i>
                    </div>
                    <h3 data-en="Audio Filtering" data-ar="تصفية الصوت">Audio Filtering</h3>
                    <p data-en="Detect and mute non-permissible music in videos and audio" data-ar="اكتشف وكتم الموسيقى غير المسموح بها في مقاطع الفيديو والصوت">Detect and mute non-permissible music in videos and audio</p>
                    <div class="filter-options">
                        <label class="switch-container">
                            <input type="checkbox" id="filter-audio">
                            <span class="slider"></span>
                            <span data-en="Enable Audio Filtering" data-ar="تفعيل تصفية الصوت">Enable Audio Filtering</span>
                        </label>
                    </div>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <h3 data-en="Real-time Statistics" data-ar="إحصائيات في الوقت الفعلي">Real-time Statistics</h3>
                    <div class="stats-container">
                        <div class="stat-item">
                            <div class="stat-value" id="faces-blurred">0</div>
                            <div class="stat-label" data-en="Faces Blurred" data-ar="وجوه تم تعتيمها">Faces Blurred</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-value" id="audios-filtered">0</div>
                            <div class="stat-label" data-en="Audios Filtered" data-ar="مقاطع صوتية تمت تصفيتها">Audios Filtered</div>
                        </div>
                    </div>
                </div>
            </section>

            <section class="extension-section">
                <h2 data-en="Browser Extension" data-ar="إضافة المتصفح">Browser Extension</h2>
                <p data-en="Install our browser extension to enable filtering on all websites you visit" data-ar="قم بتثبيت إضافة المتصفح الخاصة بنا لتمكين التصفية على جميع المواقع التي تزورها">Install our browser extension to enable filtering on all websites you visit</p>
                <div class="extension-buttons">
                    <button class="btn btn-primary" id="install-chrome">
                        <i class="fab fa-chrome"></i>
                        <span data-en="Install for Chrome" data-ar="التثبيت لمتصفح كروم">Install for Chrome</span>
                    </button>
                    <button class="btn btn-secondary" id="install-firefox">
                        <i class="fab fa-firefox"></i>
                        <span data-en="Install for Firefox" data-ar="التثبيت لمتصفح فايرفوكس">Install for Firefox</span>
                    </button>
                </div>
            </section>

            <section class="demo-section">
                <h2 data-en="Live Demo" data-ar="عرض توضيحي مباشر">Live Demo</h2>
                <div class="demo-container">
                    <div class="demo-upload">
                        <label for="demo-image" class="upload-label">
                            <i class="fas fa-cloud-upload-alt"></i>
                            <span data-en="Upload Image for Demo" data-ar="رفع صورة للعرض التوضيحي">Upload Image for Demo</span>
                        </label>
                        <input type="file" id="demo-image" accept="image/*">
                    </div>
                    <div class="demo-preview" id="demo-preview">
                        <div class="placeholder">
                            <i class="fas fa-image"></i>
                            <p data-en="Image preview will appear here" data-ar="سيظهر معاينة الصورة هنا">Image preview will appear here</p>
                        </div>
                    </div>
                </div>
                <div class="demo-controls">
                    <button class="btn btn-primary" id="process-demo" disabled>
                        <i class="fas fa-magic"></i>
                        <span data-en="Process Image" data-ar="معالجة الصورة">Process Image</span>
                    </button>
                </div>
            </section>
        </main>

        <footer>
            <div class="developer-credit">
                <p data-en="Developed by Youssef Sayed Abu Taleb, high school student (Grade 11), Fayoum Secondary School, Egypt" 
                   data-ar="تطوير يوسف سيد أبو طالب، طالب بالمرحلة الثانوية (الصف الحادي عشر)، مدرسة الفيوم الثانوية، مصر">
                   Developed by Youssef Sayed Abu Taleb, high school student (Grade 11), Fayoum Secondary School, Egypt
                </p>
            </div>
            <div class="footer-links">
                <a href="#" data-en="Privacy Policy" data-ar="سياسة الخصوصية">Privacy Policy</a>
                <a href="#" data-en="Terms of Service" data-ar="شروط الخدمة">Terms of Service</a>
                <a href="#" data-en="Contact Us" data-ar="اتصل بنا">Contact Us</a>
            </div>
        </footer>
    </div>

    <script src="script.js"></script>
</body>
</html>
