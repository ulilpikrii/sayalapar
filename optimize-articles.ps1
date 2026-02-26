# Optimization script for artikel pages
# This script replaces the head section CSS loading pattern to defer non-critical CSS

$criticalCSS = @'
    <!-- Critical CSS Inline -->
    <style>
        :root{--primary:#16a34a;--primary-dark:#15803d;--primary-light:#22c55e;--accent:#f59e0b;--dark:#0f172a;--dark-surface:#1e293b;--dark-card:#273548;--text-light:#f8fafc;--text-muted:#94a3b8;--gradient-primary:linear-gradient(135deg,#16a34a 0%,#22c55e 100%);--gradient-hero:linear-gradient(135deg,#0f172a 0%,#1e3a2f 50%,#0f172a 100%);--shadow-card:0 10px 40px rgba(0,0,0,0.15);--transition:all .3s cubic-bezier(.4,0,.2,1);--font-display:'Bebas Neue',sans-serif;--font-body:'Inter',sans-serif}*{box-sizing:border-box}html{scroll-behavior:smooth;scroll-padding-top:80px;overflow-x:hidden;max-width:100vw}body{font-family:var(--font-body);color:var(--text-light);background-color:var(--dark);overflow-x:hidden;max-width:100vw;-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale;word-wrap:break-word;overflow-wrap:break-word;margin:0}::selection{background-color:var(--primary);color:#fff}h1,h2,h3,h4,h5,h6{font-family:var(--font-display);letter-spacing:1px}a{text-decoration:none;transition:var(--transition)}img{max-width:100%;height:auto}.navbar-custom{background:rgba(15,23,42,.92)!important;backdrop-filter:blur(20px);-webkit-backdrop-filter:blur(20px);border-bottom:1px solid rgba(255,255,255,.06);padding:.6rem 0;transition:var(--transition)}.navbar-custom.scrolled{box-shadow:0 4px 30px rgba(0,0,0,.3)}.navbar-brand{font-family:var(--font-display);font-size:1.6rem!important;letter-spacing:2px;color:#fff!important;display:flex;align-items:center;gap:.5rem}.navbar-brand .brand-icon{width:40px;height:40px;background:var(--gradient-primary);border-radius:10px;display:flex;align-items:center;justify-content:center;font-size:1.2rem}.nav-link{font-family:var(--font-body);font-weight:600;font-size:.85rem;text-transform:uppercase;letter-spacing:1.5px;color:rgba(255,255,255,.7)!important;padding:.5rem 1rem!important;transition:var(--transition);position:relative}.nav-link::after{content:'';position:absolute;bottom:0;left:50%;transform:translateX(-50%);width:0;height:2px;background:var(--primary);transition:width .3s ease}.nav-link:hover,.nav-link.active{color:var(--primary)!important}.nav-link:hover::after,.nav-link.active::after{width:60%}.btn-navbar-cta{background:var(--gradient-primary);color:#fff;font-weight:700;font-size:.8rem;text-transform:uppercase;letter-spacing:1px;padding:.6rem 1.5rem;border:none;border-radius:50px;transition:var(--transition);display:flex;align-items:center;gap:.5rem}.offcanvas{background-color:var(--dark)!important;border-left:1px solid rgba(255,255,255,.06)!important}.section-label{font-family:var(--font-body);font-weight:700;font-size:.8rem;text-transform:uppercase;letter-spacing:3px;color:var(--primary);margin-bottom:.5rem}.section-title{font-family:var(--font-display);font-size:clamp(2rem,5vw,3.5rem);color:#fff;letter-spacing:2px;line-height:1.1}.section-desc{color:var(--text-muted);font-size:1rem;font-weight:300;line-height:1.8}.section-dark{background-color:var(--dark);padding:5rem 0}.article-hero{position:relative;padding:8rem 0 3rem;background:var(--gradient-hero)}.article-content{font-family:var(--font-body);font-size:1.05rem;line-height:1.9;color:rgba(255,255,255,.85)}.article-content h2{font-family:var(--font-body);font-weight:800;font-size:1.8rem;color:#fff;margin:2.5rem 0 1rem;letter-spacing:normal}.article-content h3{font-family:var(--font-body);font-weight:700;font-size:1.4rem;color:#fff;margin:2rem 0 .8rem;letter-spacing:normal}.article-content p{margin-bottom:1.2rem}.article-content img{border-radius:12px;margin:1.5rem 0;width:100%}.article-content blockquote{border-left:4px solid var(--primary);padding:1.5rem 2rem;margin:2rem 0;background:rgba(22,163,74,.05);border-radius:0 12px 12px 0;font-style:italic;color:rgba(255,255,255,.9)}.article-content ul,.article-content ol{margin:1rem 0 1.5rem 1.5rem}.article-content li{margin-bottom:.5rem}.toc-container{background:var(--dark-card);border:1px solid rgba(255,255,255,.06);border-radius:16px;padding:1.5rem;margin:2rem 0}.toc-toggle{background:none;border:none;color:#fff;font-weight:700;font-size:1rem;cursor:pointer;display:flex;align-items:center;justify-content:space-between;width:100%;padding:0}.toc-list{list-style:none;padding:0;margin:1rem 0 0}.toc-list li{margin-bottom:.5rem}.toc-list a{color:var(--text-muted);font-size:.9rem;display:block;padding:.3rem 0 .3rem 1rem;border-left:2px solid transparent}.faq-item{background:var(--dark-card);border:1px solid rgba(255,255,255,.06);border-radius:12px;margin-bottom:.8rem;overflow:hidden}.faq-question{background:none;border:none;color:#fff;font-weight:600;font-size:1rem;padding:1.2rem 1.5rem;width:100%;text-align:left;cursor:pointer;display:flex;align-items:center;justify-content:space-between}.faq-answer{padding:0 1.5rem 1.2rem;color:var(--text-muted);font-size:.9rem;line-height:1.7;display:none}.faq-item.active .faq-answer{display:block}.faq-item.active .faq-question .faq-icon{transform:rotate(45deg)}.author-box{background:var(--dark-card);border:1px solid rgba(255,255,255,.06);border-radius:16px;padding:2rem;display:flex;gap:1.5rem;align-items:center;margin:2rem 0}.author-avatar{width:80px;height:80px;min-width:80px;border-radius:50%;object-fit:cover;border:3px solid var(--primary)}.author-name{font-weight:700;font-size:1.1rem;color:#fff;margin-bottom:.3rem}.author-bio{font-size:.85rem;color:var(--text-muted);line-height:1.6;margin:0}.share-buttons{display:flex;gap:.8rem;flex-wrap:wrap}.btn-share{width:42px;height:42px;border-radius:10px;border:1px solid rgba(255,255,255,.1);background:rgba(255,255,255,.05);color:#fff;display:flex;align-items:center;justify-content:center;font-size:1rem;cursor:pointer;text-decoration:none}.baca-juga{background:rgba(22,163,74,.05);border:1px solid rgba(22,163,74,.15);border-radius:12px;padding:1.5rem;margin:2rem 0}.baca-juga h4{font-family:var(--font-body);font-weight:700;color:var(--primary);margin-bottom:1rem;font-size:1rem}.baca-juga a{color:var(--primary-light);display:block;padding:.3rem 0;font-size:.9rem}.img-caption{font-size:.8rem;color:var(--text-muted);text-align:center;font-style:italic;margin-top:-.5rem;margin-bottom:1.5rem}.article-card{background:var(--dark-card);border:1px solid rgba(255,255,255,.06);border-radius:16px;overflow:hidden;transition:var(--transition);height:100%;display:flex;flex-direction:column}.article-card-img{position:relative;height:220px;overflow:hidden}.article-card-img img{width:100%;height:100%;object-fit:cover}.article-card-tag{position:absolute;top:1rem;left:1rem;background:var(--gradient-primary);color:#fff;font-size:.7rem;font-weight:700;text-transform:uppercase;letter-spacing:1px;padding:.3rem .8rem;border-radius:50px}.article-card-body{padding:1.5rem;flex:1;display:flex;flex-direction:column}.article-card-meta{font-size:.75rem;color:var(--text-muted);margin-bottom:.8rem;display:flex;align-items:center;gap:1rem}.article-card-title{font-family:var(--font-body);font-weight:700;font-size:1.1rem;color:#fff;margin-bottom:.8rem;line-height:1.4;letter-spacing:normal}.article-card-excerpt{font-size:.85rem;color:var(--text-muted);line-height:1.6;margin-bottom:1.2rem;flex:1}.article-card-link{color:var(--primary);font-weight:700;font-size:.85rem;text-transform:uppercase;letter-spacing:1px;display:inline-flex;align-items:center;gap:.5rem}.btn-hero-primary{background:var(--gradient-primary);color:#fff;font-weight:700;font-size:1rem;padding:1rem 2.5rem;border:none;border-radius:50px;transition:var(--transition);display:inline-flex;align-items:center;gap:.7rem;text-transform:uppercase;letter-spacing:1px}.btn-hero-primary:hover{transform:translateY(-3px);box-shadow:0 8px 30px rgba(22,163,74,.4);color:#fff}.fade-up{opacity:0;transform:translateY(30px);transition:opacity .6s ease,transform .6s ease}.fade-up.visible{opacity:1;transform:translateY(0)}.floating-buttons{position:fixed;bottom:2rem;right:2rem;z-index:9999;display:flex;flex-direction:column;gap:.8rem;align-items:center}.btn-wa-float{width:56px;height:56px;border-radius:50%;background:linear-gradient(135deg,#25d366 0%,#128c7e 100%);color:#fff;border:none;display:flex;align-items:center;justify-content:center;font-size:1.6rem;box-shadow:0 4px 20px rgba(37,211,102,.4);transition:var(--transition);cursor:pointer;animation:waFloat 3s ease-in-out infinite;text-decoration:none}@keyframes waFloat{0%,100%{transform:translateY(0)}50%{transform:translateY(-5px)}}.btn-scroll-top{width:46px;height:46px;border-radius:50%;background:rgba(255,255,255,.1);backdrop-filter:blur(10px);border:1px solid rgba(255,255,255,.15);color:#fff;display:flex;align-items:center;justify-content:center;font-size:1.2rem;cursor:pointer;transition:var(--transition);opacity:0;visibility:hidden;transform:translateY(20px)}.btn-scroll-top.show{opacity:1;visibility:visible;transform:translateY(0)}.footer{background:linear-gradient(180deg,var(--dark-surface) 0%,var(--dark) 100%);border-top:1px solid rgba(255,255,255,.05)}.footer-brand-text{font-family:var(--font-display);font-size:2rem;letter-spacing:2px;color:#fff}.footer-desc{color:var(--text-muted);font-size:.9rem;line-height:1.7}.footer-title{font-family:var(--font-body);font-weight:700;font-size:1rem;color:#fff;text-transform:uppercase;letter-spacing:1px;margin-bottom:1.5rem;position:relative;padding-bottom:.8rem}.footer-title::after{content:'';position:absolute;bottom:0;left:0;width:30px;height:2px;background:var(--primary)}.footer-links{list-style:none;padding:0;margin:0}.footer-links li{margin-bottom:.7rem}.footer-links a{color:var(--text-muted);font-size:.9rem;transition:var(--transition)}.footer-contact-item{display:flex;align-items:flex-start;gap:1rem;margin-bottom:1rem;color:var(--text-muted);font-size:.9rem}.footer-contact-icon{width:40px;height:40px;min-width:40px;background:rgba(22,163,74,.1);border-radius:10px;display:flex;align-items:center;justify-content:center;color:var(--primary)}.footer-social{display:flex;gap:.8rem}.footer-social a{width:42px;height:42px;background:rgba(255,255,255,.05);border:1px solid rgba(255,255,255,.08);border-radius:10px;display:flex;align-items:center;justify-content:center;color:var(--text-muted);font-size:1.1rem}.footer-bottom{border-top:1px solid rgba(255,255,255,.05);padding:1.5rem 0;margin-top:3rem}.footer-bottom p{color:var(--text-muted);font-size:.8rem;margin:0}@media(max-width:767.98px){.section-dark{padding:3rem 0}.floating-buttons{bottom:1.2rem;right:1.2rem}.btn-wa-float{width:50px;height:50px;font-size:1.4rem}.btn-scroll-top{width:40px;height:40px}.author-box{flex-direction:column;text-align:center}.article-content h2{font-size:1.5rem}.article-content h3{font-size:1.2rem}}@media(max-width:575.98px){.section-title{font-size:clamp(1.5rem,7vw,1.8rem)}.btn-hero-primary{width:100%;justify-content:center}}
    </style>
'@

$deferredCSS = @'
    <!-- Non-Critical CSS: Bootstrap (deferred) -->
    <link rel="preload" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" as="style"
        onload="this.onload=null;this.rel='stylesheet'">
    <noscript>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </noscript>

    <!-- Google Fonts Async -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&family=Bebas+Neue&display=swap"
        rel="preload" as="style" onload="this.onload=null;this.rel='stylesheet'">
    <noscript>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&family=Bebas+Neue&display=swap"
            rel="stylesheet">
    </noscript>

    <!-- Bootstrap Icons Async -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="preload"
        as="style" onload="this.onload=null;this.rel='stylesheet'">
    <noscript>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
            rel="stylesheet">
    </noscript>

    <!-- Custom CSS (deferred) -->
    <link rel="preload" href="css/style.css" as="style" onload="this.onload=null;this.rel='stylesheet'">
    <noscript>
        <link href="css/style.css" rel="stylesheet">
    </noscript>
'@

foreach ($file in @("artikel-1.html","artikel-2.html","artikel-3.html","artikel-4.html","artikel-5.html")) {
    Write-Host "Processing $file..."
    $content = Get-Content -Path $file -Raw -Encoding UTF8
    
    # Replace the old CSS loading block with critical CSS + deferred loading
    # Pattern: from preconnect section through custom CSS link
    
    # Remove old preload lines for bootstrap CSS
    $content = $content -replace '(?m)^\s*<link rel="preload" href="https://cdn\.jsdelivr\.net/npm/bootstrap@5\.3\.3/dist/css/bootstrap\.min\.css" as="style">\s*\r?\n', ''
    $content = $content -replace '(?m)^\s*<link rel="preload" href="css/style\.css" as="style">\s*\r?\n', ''
    $content = $content -replace '(?m)^\s*<!-- Preload Critical CSS -->\s*\r?\n', ''
    
    # Replace synchronous Bootstrap CSS with deferred version
    $content = $content -replace '(?s)<link href="https://cdn\.jsdelivr\.net/npm/bootstrap@5\.3\.3/dist/css/bootstrap\.min\.css" rel="stylesheet">', ''
    
    # Replace Bootstrap Icons loading block
    $content = $content -replace '(?s)<link href="https://cdn\.jsdelivr\.net/npm/bootstrap-icons@1\.11\.3/font/bootstrap-icons\.min\.css" rel="preload" as="style">\s*\r?\n\s*<link href="https://cdn\.jsdelivr\.net/npm/bootstrap-icons@1\.11\.3/font/bootstrap-icons\.min\.css" rel="stylesheet" media="print" onload="this\.media=''all''">\s*\r?\n\s*<noscript><link href="https://cdn\.jsdelivr\.net/npm/bootstrap-icons@1\.11\.3/font/bootstrap-icons\.min\.css" rel="stylesheet"></noscript>', ''
    $content = $content -replace '(?s)<link href="https://cdn\.jsdelivr\.net/npm/bootstrap-icons@1\.11\.3/font/bootstrap-icons\.min\.css" rel="preload"\s*\r?\n\s*as="style">\s*\r?\n\s*<link href="https://cdn\.jsdelivr\.net/npm/bootstrap-icons@1\.11\.3/font/bootstrap-icons\.min\.css" rel="stylesheet"\s*\r?\n\s*media="print" onload="this\.media=''all''">\s*\r?\n\s*<noscript>\s*\r?\n\s*<link href="https://cdn\.jsdelivr\.net/npm/bootstrap-icons@1\.11\.3/font/bootstrap-icons\.min\.css" rel="stylesheet">\s*\r?\n\s*</noscript>', ''
    
    # Replace Google Fonts loading block  
    $content = $content -replace '(?s)<link href="https://fonts\.googleapis\.com/css2\?family=Inter:wght@300;400;500;600;700&family=Bebas\+Neue&display=swap" rel="preload" as="style">\s*\r?\n\s*<link href="https://fonts\.googleapis\.com/css2\?family=Inter:wght@300;400;500;600;700&family=Bebas\+Neue&display=swap" rel="stylesheet" media="print" onload="this\.media=''all''">\s*\r?\n\s*<noscript><link href="https://fonts\.googleapis\.com/css2\?family=Inter:wght@300;400;500;600;700&family=Bebas\+Neue&display=swap" rel="stylesheet"></noscript>', ''
    $content = $content -replace '(?s)<!-- Google Fonts Async -->\s*\r?\n\s*<link href="https://fonts\.googleapis\.com/css2\?family=Inter:wght@300;400;500;600;700&family=Bebas\+Neue&display=swap" rel="preload" as="style">\s*\r?\n\s*<link href="https://fonts\.googleapis\.com/css2\?family=Inter:wght@300;400;500;600;700&family=Bebas\+Neue&display=swap" rel="stylesheet" media="print" onload="this\.media=''all''">\s*\r?\n\s*<noscript>\s*<link href="https://fonts\.googleapis\.com/css2\?family=Inter:wght@300;400;500;600;700&family=Bebas\+Neue&display=swap" rel="stylesheet">\s*</noscript>', ''
    
    # Replace the custom CSS link
    $content = $content -replace '(?m)^\s*<link href="css/style\.css" rel="stylesheet">\s*$', ''
    
    # Now insert critical CSS + deferred CSS after the preconnect block
    $content = $content -replace '(<link rel="preconnect" href="https://cdn\.jsdelivr\.net" crossorigin>)', "`$1`r`n`r`n$criticalCSS`r`n$deferredCSS"
    
    # Add decoding="async" to lazy images
    $content = $content -replace 'loading="lazy">', 'loading="lazy" decoding="async">'
    $content = $content -replace 'loading="eager">', 'loading="eager" decoding="async">'
    
    # Remove the old preload for hero image on article pages  
    $content = $content -replace '(?m)^\s*<link rel="preload" href="images/hero-rafting\.webp" as="image" fetchpriority="high">\s*\r?\n', ''
    
    # Clean up multiple blank lines
    $content = $content -replace '(\r?\n){4,}', "`r`n`r`n"
    
    # Write back UTF-8 without BOM
    $utf8NoBom = New-Object System.Text.UTF8Encoding $false
    [System.IO.File]::WriteAllText("$PWD\$file", $content, $utf8NoBom)
    Write-Host "Done: $file"
}

Write-Host "All artikel pages optimized!"
