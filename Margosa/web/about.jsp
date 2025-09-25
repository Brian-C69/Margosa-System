<%--
    Document   : about
    Created on : Jun 28, 2023, 8:37:55 PM
    Author     : Bernard
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/headers.html"/>
        <title>MyMargosaApp | About</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
        <style>
            :root {
                --primary: #2563eb;
                --accent: #38bdf8;
                --emerald: #34d399;
                --dark: #0f172a;
                --muted: #475569;
                --light: #f7f9fc;
            }

            body {
                font-family: 'Poppins', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: var(--light);
                color: #1f2937;
            }

            .page-wrapper {
                overflow: hidden;
            }

            .hero {
                background: radial-gradient(circle at top left, rgba(56, 189, 248, 0.35), rgba(37, 99, 235, 0.85)),
                            linear-gradient(140deg, #1e3a8a 0%, #2563eb 55%, #38bdf8 100%);
                color: #ffffff;
                position: relative;
            }

            .hero::after {
                content: "";
                position: absolute;
                inset: 0;
                background: url('data:image/svg+xml,%3Csvg xmlns="http://www.w3.org/2000/svg" width="160" height="160" viewBox="0 0 40 40" fill="none"%3E%3Cpath d="M0 39L1 40H0V39Z" fill="white" fill-opacity="0.05"/%3E%3C/svg%3E') repeat;
                opacity: 0.18;
                z-index: 0;
            }

            .hero .container {
                position: relative;
                z-index: 1;
            }

            .hero-badge {
                background: rgba(255, 255, 255, 0.14);
                border-radius: 999px;
                display: inline-flex;
                align-items: center;
                gap: 0.6rem;
                padding: 0.55rem 1.3rem;
                letter-spacing: 0.05em;
                text-transform: uppercase;
                font-size: 0.9rem;
                font-weight: 500;
            }

            .hero-title {
                font-size: clamp(2.4rem, 4vw, 3.4rem);
                font-weight: 700;
                line-height: 1.1;
            }

            .hero-subtitle {
                font-size: 1.1rem;
                color: rgba(255, 255, 255, 0.82);
            }

            .impact-card {
                background: rgba(255, 255, 255, 0.12);
                border-radius: 1.5rem;
                padding: 1.75rem;
                height: 100%;
            }

            .impact-card h3 {
                font-size: 2.1rem;
                font-weight: 700;
            }

            .section-title {
                font-weight: 700;
                color: var(--dark);
            }

            .section-subtitle {
                max-width: 720px;
                margin: 0 auto 2.5rem auto;
                color: var(--muted);
            }

            .value-card {
                background: #ffffff;
                border-radius: 1.5rem;
                padding: 2.2rem 2rem;
                box-shadow: 0 20px 45px rgba(15, 23, 42, 0.12);
                height: 100%;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .value-card:hover {
                transform: translateY(-8px);
                box-shadow: 0 28px 60px rgba(15, 23, 42, 0.18);
            }

            .value-icon {
                width: 3.5rem;
                height: 3.5rem;
                border-radius: 1.25rem;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                font-size: 1.75rem;
                margin-bottom: 1.1rem;
                color: var(--primary);
                background: rgba(37, 99, 235, 0.12);
            }

            .timeline {
                position: relative;
                margin: 0;
                padding-left: 1.5rem;
                list-style: none;
            }

            .timeline::before {
                content: "";
                position: absolute;
                top: 0.4rem;
                bottom: 0.4rem;
                left: 0.55rem;
                width: 2px;
                background: linear-gradient(to bottom, rgba(37, 99, 235, 0.15), rgba(37, 99, 235, 0.45));
            }

            .timeline-item {
                position: relative;
                padding-left: 1.5rem;
                margin-bottom: 1.8rem;
            }

            .timeline-item:last-child {
                margin-bottom: 0;
            }

            .timeline-bullet {
                position: absolute;
                left: -0.06rem;
                top: 0.35rem;
                width: 0.9rem;
                height: 0.9rem;
                background: #ffffff;
                border: 3px solid var(--primary);
                border-radius: 50%;
            }

            .community-grid {
                display: grid;
                grid-template-columns: repeat(3, minmax(0, 1fr));
                gap: 1.5rem;
            }

            .community-card {
                background: linear-gradient(135deg, rgba(37, 99, 235, 0.08), rgba(59, 130, 246, 0.18));
                border-radius: 1.75rem;
                padding: 2rem;
                display: flex;
                flex-direction: column;
                gap: 0.75rem;
            }

            .community-card strong {
                font-size: 1.65rem;
                color: var(--dark);
            }

            .community-card span {
                color: var(--muted);
            }

            .cta-section {
                background: #ffffff;
                border-radius: 2rem;
                box-shadow: 0 25px 55px rgba(15, 23, 42, 0.12);
                padding: 3rem;
                position: relative;
                overflow: hidden;
            }

            .cta-section::before {
                content: "";
                position: absolute;
                inset: auto -90px -90px auto;
                width: 260px;
                height: 260px;
                background: linear-gradient(135deg, rgba(37, 99, 235, 0.15), rgba(56, 189, 248, 0.25));
                border-radius: 50%;
            }

            .cta-section::after {
                content: "";
                position: absolute;
                inset: -100px auto auto -100px;
                width: 220px;
                height: 220px;
                background: linear-gradient(135deg, rgba(37, 99, 235, 0.15), rgba(56, 189, 248, 0.25));
                border-radius: 50%;
            }

            .cta-section > * {
                position: relative;
                z-index: 1;
            }

            @media (max-width: 991.98px) {
                .hero-title {
                    font-size: clamp(2.1rem, 6vw, 3rem);
                }

                .community-grid {
                    grid-template-columns: repeat(2, minmax(0, 1fr));
                }
            }

            @media (max-width: 767.98px) {
                .hero {
                    text-align: center;
                }

                .impact-card {
                    margin-top: 1.5rem;
                }

                .community-grid {
                    grid-template-columns: 1fr;
                }

                .cta-section {
                    padding: 2.3rem;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="includes/navbar.jsp"/>
        <div class="page-wrapper">
            <section class="hero py-5 py-lg-6">
                <div class="container py-5">
                    <div class="row align-items-center g-4">
                        <div class="col-lg-7">
                            <div class="hero-badge mb-3">
                                <i class="bi bi-people-fill"></i>
                                Built with and for the Margosa community
                            </div>
                            <h1 class="hero-title mb-4">Empowering every neighbor to feel informed, safe, and connected.</h1>
                            <p class="hero-subtitle mb-4">MyMSBSApp exists to simplify daily life for Margosa residents. From transparent governance to effortless collaboration, we deliver the digital foundation for a thriving neighborhood.</p>
                            <div class="d-flex flex-wrap gap-3">
                                <a href="register.jsp" class="btn btn-light btn-lg px-4 py-2 fw-semibold">
                                    Join the community
                                </a>
                                <a href="login.jsp" class="btn btn-outline-light btn-lg px-4 py-2 fw-semibold">
                                    Explore resident tools
                                </a>
                            </div>
                        </div>
                        <div class="col-lg-5">
                            <div class="impact-card text-white h-100 d-flex flex-column justify-content-center">
                                <h3 class="mb-2">1 unified app</h3>
                                <p class="mb-4">Bringing together committees, guards, residents, and visitors in one secure space.</p>
                                <div class="d-flex align-items-center gap-3 mb-3">
                                    <span class="badge bg-light text-dark rounded-pill px-3 py-2">
                                        <i class="bi bi-shield-lock"></i> Secure access
                                    </span>
                                    <span class="badge bg-light text-dark rounded-pill px-3 py-2">
                                        <i class="bi bi-chat-dots"></i> Open dialogue
                                    </span>
                                </div>
                                <div class="small text-white-50">Trusted digital infrastructure crafted to reflect Margosa values.</div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <section class="py-5">
                <div class="container py-4">
                    <div class="text-center mb-5">
                        <span class="badge bg-primary bg-opacity-10 text-primary rounded-pill px-4 py-2 fw-semibold">
                            <i class="bi bi-bullseye"></i> Our Mission
                        </span>
                        <h2 class="section-title mt-3 mb-3">Built to nurture a resilient Margosa</h2>
                        <p class="section-subtitle">Born from a shared desire to streamline community life, MyMSBSApp delivers intuitive tools that keep residents informed, foster accountability, and celebrate the spirit of collaboration that defines our streets.</p>
                    </div>
                    <div class="row g-4">
                        <div class="col-md-4">
                            <div class="value-card h-100">
                                <div class="value-icon">
                                    <i class="bi bi-heart-pulse"></i>
                                </div>
                                <h4 class="fw-semibold mb-2">People-first experiences</h4>
                                <p class="mb-0 text-secondary">Every feature is designed around the daily rhythms of residents, making it effortless to coordinate committees, manage visitors, and share updates.</p>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="value-card h-100">
                                <div class="value-icon">
                                    <i class="bi bi-lightning-charge"></i>
                                </div>
                                <h4 class="fw-semibold mb-2">Responsive to change</h4>
                                <p class="mb-0 text-secondary">Our agile platform evolves alongside Margosa needs—adding new workflows, refining security, and surfacing insights for proactive decisions.</p>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="value-card h-100">
                                <div class="value-icon">
                                    <i class="bi bi-stars"></i>
                                </div>
                                <h4 class="fw-semibold mb-2">Celebrating community wins</h4>
                                <p class="mb-0 text-secondary">From welcoming new neighbors to honoring volunteers, MyMSBSApp keeps achievements visible so every resident feels appreciated.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <section class="py-5 bg-white">
                <div class="container py-4">
                    <div class="row g-5 align-items-center">
                        <div class="col-lg-6">
                            <span class="badge bg-primary bg-opacity-10 text-primary rounded-pill px-4 py-2 fw-semibold">
                                <i class="bi bi-diagram-3"></i> How we serve you
                            </span>
                            <h2 class="section-title mt-3 mb-3">Connecting every corner of Margosa</h2>
                            <p class="text-secondary mb-4">Whether you are coordinating a guard shift, registering a visitor, or requesting committee support, MyMSBSApp brings clarity to every interaction. Our modules are intentionally integrated so information flows in real time.</p>
                            <ul class="timeline">
                                <li class="timeline-item">
                                    <span class="timeline-bullet"></span>
                                    <h5 class="fw-semibold mb-1">Resident empowerment</h5>
                                    <p class="mb-0 text-secondary">Self-service tools for visitor codes, vehicle passes, and household records put control back in your hands.</p>
                                </li>
                                <li class="timeline-item">
                                    <span class="timeline-bullet"></span>
                                    <h5 class="fw-semibold mb-1">Coordinated governance</h5>
                                    <p class="mb-0 text-secondary">Committee dashboards illuminate trends, approvals, and requests so leaders can respond quickly and transparently.</p>
                                </li>
                                <li class="timeline-item">
                                    <span class="timeline-bullet"></span>
                                    <h5 class="fw-semibold mb-1">Guard partnership</h5>
                                    <p class="mb-0 text-secondary">Smart guard consoles streamline visitor verification and entry logs, strengthening security without slowing arrivals.</p>
                                </li>
                            </ul>
                        </div>
                        <div class="col-lg-6">
                            <div class="community-grid">
                                <div class="community-card">
                                    <strong>24/7</strong>
                                    <span>Access to essential community services no matter where you are.</span>
                                </div>
                                <div class="community-card">
                                    <strong>360°</strong>
                                    <span>Visibility across residents, committees, and guards with unified data.</span>
                                </div>
                                <div class="community-card">
                                    <strong>100%</strong>
                                    <span>Commitment to safeguarding privacy with role-based controls and secure infrastructure.</span>
                                </div>
                                <div class="community-card">
                                    <strong>Minutes</strong>
                                    <span>To register visitors or manage vehicles—saving hours every week for busy families.</span>
                                </div>
                                <div class="community-card">
                                    <strong>Zero</strong>
                                    <span>Paper logs required thanks to digital workflows and automated notifications.</span>
                                </div>
                                <div class="community-card">
                                    <strong>Unlimited</strong>
                                    <span>Opportunities to co-create new features alongside fellow residents.</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <section class="py-5">
                <div class="container py-4">
                    <div class="row g-5 align-items-center">
                        <div class="col-lg-5">
                            <span class="badge bg-primary bg-opacity-10 text-primary rounded-pill px-4 py-2 fw-semibold">
                                <i class="bi bi-flag"></i> Our journey so far
                            </span>
                            <h2 class="section-title mt-3 mb-3">A story shaped by resident voices</h2>
                            <p class="text-secondary mb-0">What started as a simple request for better visitor tracking evolved into a comprehensive neighborhood platform. Each release incorporates suggestions from Margosa households, ensuring the app feels familiar and practical from day one.</p>
                        </div>
                        <div class="col-lg-7">
                            <div class="row g-4">
                                <div class="col-md-6">
                                    <div class="value-card h-100">
                                        <div class="value-icon">
                                            <i class="bi bi-lightbulb"></i>
                                        </div>
                                        <h4 class="fw-semibold mb-2">Ideation workshops</h4>
                                        <p class="mb-0 text-secondary">Quarterly listening sessions capture needs from families, guards, and committee leads to guide our roadmap.</p>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="value-card h-100">
                                        <div class="value-icon">
                                            <i class="bi bi-people"></i>
                                        </div>
                                        <h4 class="fw-semibold mb-2">Inclusive testing</h4>
                                        <p class="mb-0 text-secondary">Pilot groups validate new workflows before launch, ensuring features are intuitive and accessible.</p>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="value-card h-100">
                                        <div class="value-icon">
                                            <i class="bi bi-graph-up-arrow"></i>
                                        </div>
                                        <h4 class="fw-semibold mb-2">Measurable impact</h4>
                                        <p class="mb-0 text-secondary">Real-time dashboards reveal adoption, response times, and resident satisfaction so we keep improving.</p>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="value-card h-100">
                                        <div class="value-icon">
                                            <i class="bi bi-award"></i>
                                        </div>
                                        <h4 class="fw-semibold mb-2">Community recognition</h4>
                                        <p class="mb-0 text-secondary">Celebrating volunteer achievements and milestones reinforces the pride of belonging to Margosa.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <section class="py-5">
                <div class="container py-4">
                    <div class="cta-section text-center">
                        <div class="mb-3">
                            <span class="badge bg-primary bg-opacity-10 text-primary rounded-pill px-4 py-2 fw-semibold">
                                <i class="bi bi-chat-heart"></i> Let’s build together
                            </span>
                        </div>
                        <h2 class="section-title mb-3">Your ideas shape the future of MyMSBSApp</h2>
                        <p class="text-secondary mb-4 mx-auto" style="max-width: 680px;">We believe technology should always reflect the people it serves. Share your feedback, propose new features, and partner with us to create the digital experience Margosa deserves.</p>
                        <div class="d-flex flex-wrap justify-content-center gap-3">
                            <a href="register.jsp" class="btn btn-primary btn-lg px-4 py-2 fw-semibold">
                                Become a resident collaborator
                            </a>
                            <a href="mailto:info@mymargosaapp.com" class="btn btn-outline-primary btn-lg px-4 py-2 fw-semibold">
                                Send feedback
                            </a>
                        </div>
                    </div>
                </div>
            </section>
        </div>
        <jsp:include page="includes/footer.html"/>
    </body>
</html>
