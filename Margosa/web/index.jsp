<%--
    Document   : index
    Created on : Jun 28, 2023, 1:47:36 AM
    Author     : Bernard
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/headers.html"/>
        <title>MyMSBSApp | Home</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
        <style>
            :root {
                --primary: #2563eb;
                --accent: #38bdf8;
                --dark: #0f172a;
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
                            linear-gradient(135deg, #1e3a8a 0%, #2563eb 45%, #38bdf8 100%);
                color: #ffffff;
                position: relative;
            }

            .hero::after {
                content: "";
                position: absolute;
                inset: 0;
                background: url('data:image/svg+xml,%3Csvg xmlns="http://www.w3.org/2000/svg" width="160" height="160" viewBox="0 0 40 40" fill="none"%3E%3Cpath d="M0 39L1 40H0V39Z" fill="white" fill-opacity="0.05"/%3E%3C/svg%3E') repeat;
                opacity: 0.15;
                z-index: 0;
            }

            .hero .container {
                position: relative;
                z-index: 1;
            }

            .hero-highlight {
                background: rgba(255, 255, 255, 0.12);
                border-radius: 9999px;
                display: inline-flex;
                align-items: center;
                padding: 0.6rem 1.4rem;
                font-size: 0.95rem;
                font-weight: 500;
                letter-spacing: 0.05em;
                text-transform: uppercase;
            }

            .hero-highlight i {
                margin-right: 0.6rem;
            }

            .hero-title {
                font-size: clamp(2.5rem, 5vw, 3.4rem);
                font-weight: 700;
                line-height: 1.1;
            }

            .hero-subtitle {
                font-size: 1.1rem;
                color: rgba(255, 255, 255, 0.85);
            }

            .checklist {
                list-style: none;
                padding: 0;
                margin: 1.5rem 0;
            }

            .checklist li {
                display: flex;
                align-items: center;
                gap: 0.75rem;
                margin-bottom: 0.75rem;
            }

            .checklist i {
                color: #34d399;
                font-size: 1.25rem;
            }

            .stat-card {
                background: rgba(255, 255, 255, 0.12);
                border-radius: 1.25rem;
                padding: 1.5rem;
                height: 100%;
            }

            .stat-card h3 {
                font-size: 2.25rem;
                font-weight: 700;
            }

            .feature-card {
                background: #ffffff;
                border: none;
                border-radius: 1.5rem;
                padding: 2.25rem 2rem;
                box-shadow: 0 20px 45px rgba(15, 23, 42, 0.12);
                height: 100%;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .feature-card:hover {
                transform: translateY(-8px);
                box-shadow: 0 26px 60px rgba(15, 23, 42, 0.18);
            }

            .feature-icon {
                width: 3.75rem;
                height: 3.75rem;
                border-radius: 1.25rem;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.8rem;
                background: rgba(37, 99, 235, 0.12);
                color: var(--primary);
                margin-bottom: 1.5rem;
            }

            .section-title {
                font-weight: 700;
                color: var(--dark);
            }

            .section-subtitle {
                max-width: 680px;
                margin: 0 auto 2.5rem auto;
                color: #4b5563;
            }

            .benefits-card {
                background: linear-gradient(135deg, rgba(37, 99, 235, 0.08), rgba(59, 130, 246, 0.18));
                border-radius: 1.75rem;
                padding: 2rem;
            }

            .benefits-card .badge {
                background: rgba(37, 99, 235, 0.18);
                color: var(--dark);
            }

            .cta-section {
                background: linear-gradient(140deg, #1e3a8a 0%, #2563eb 55%, #38bdf8 100%);
                color: #ffffff;
                border-radius: 2rem;
                padding: 3rem;
                position: relative;
                overflow: hidden;
            }

            .cta-section::before {
                content: "";
                position: absolute;
                width: 280px;
                height: 280px;
                background: rgba(255, 255, 255, 0.08);
                border-radius: 50%;
                top: -60px;
                right: -60px;
            }

            .cta-section::after {
                content: "";
                position: absolute;
                width: 200px;
                height: 200px;
                background: rgba(255, 255, 255, 0.08);
                border-radius: 50%;
                bottom: -40px;
                left: -40px;
            }

            .cta-section > * {
                position: relative;
                z-index: 1;
            }

            @media (max-width: 991.98px) {
                .hero {
                    text-align: center;
                }

                .hero-actions {
                    justify-content: center;
                }
            }

            @media (max-width: 575.98px) {
                .hero-actions .btn {
                    width: 100%;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="includes/navbar.jsp"/>
        <main class="page-wrapper">
            <section class="hero py-5 py-lg-5">
                <div class="container py-5">
                    <div class="row align-items-center g-5">
                        <div class="col-lg-7">
                            <span class="hero-highlight">
                                <i class="bi bi-people-fill"></i>
                                Smart living for the Margosa community
                            </span>
                            <h1 class="hero-title mt-4">Connect, protect, and empower every household</h1>
                            <p class="hero-subtitle mt-3">
                                MyMSBSApp centralizes visitor logs, family data, vehicle access, and community-wide alerts so your neighborhood stays informed, safe, and engaged—wherever you are.
                            </p>
                            <ul class="checklist">
                                <li><i class="bi bi-check-circle-fill"></i>Instant oversight of visitors, deliveries, and service providers.</li>
                                <li><i class="bi bi-check-circle-fill"></i>Shared tools that keep families updated and emergency-ready.</li>
                                <li><i class="bi bi-check-circle-fill"></i>Real-time alerts that bring transparency to community life.</li>
                            </ul>
                            <div class="hero-actions d-flex flex-wrap align-items-center gap-3 mt-4">
                                <a href="register.jsp" class="btn btn-lg btn-light text-primary fw-semibold px-4">
                                    <i class="bi bi-person-plus-fill me-2"></i>Join the community
                                </a>
                                <a href="#features" class="btn btn-lg btn-outline-light fw-semibold px-4">
                                    <i class="bi bi-lightning-charge me-2"></i>Explore the benefits
                                </a>
                            </div>
                        </div>
                        <div class="col-lg-5">
                            <div class="stat-card shadow-lg">
                                <h3>360° insight</h3>
                                <p class="mb-4">One central dashboard keeps estate managers and residents aligned with visitor logs, household records, and guard notes in real time.</p>
                                <div class="d-flex flex-column gap-3">
                                    <div class="d-flex align-items-center">
                                        <div class="feature-icon me-3 bg-white text-primary"><i class="bi bi-shield-check"></i></div>
                                        <div>
                                            <h5 class="mb-1">20% faster gate passes</h5>
                                            <small class="text-white-50">Automated approvals streamline daily entries.</small>
                                        </div>
                                    </div>
                                    <div class="d-flex align-items-center">
                                        <div class="feature-icon me-3 bg-white text-primary"><i class="bi bi-chat-dots"></i></div>
                                        <div>
                                            <h5 class="mb-1">Always-on updates</h5>
                                            <small class="text-white-50">Bulletins and alerts reach every resident instantly.</small>
                                        </div>
                                    </div>
                                    <div class="d-flex align-items-center">
                                        <div class="feature-icon me-3 bg-white text-primary"><i class="bi bi-people"></i></div>
                                        <div>
                                            <h5 class="mb-1">Stronger collaboration</h5>
                                            <small class="text-white-50">Committees, guards, and families share a single source of truth.</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <section class="py-5 bg-white" id="features">
                <div class="container">
                    <div class="text-center mb-5">
                        <span class="badge rounded-pill text-bg-light px-3 py-2">What you get</span>
                        <h2 class="section-title mt-3">All the essentials for a thriving gated community</h2>
                        <p class="section-subtitle">We designed MyMSBSApp alongside residents and estate managers in Margosa so every feature removes a headache and adds peace of mind.</p>
                    </div>
                    <div class="row g-4">
                        <div class="col-md-6 col-lg-4">
                            <div class="feature-card h-100">
                                <div class="feature-icon"><i class="bi bi-journal-check"></i></div>
                                <h4>Visitor & Contractor Passes</h4>
                                <p class="text-muted">Digitize entry logs, pre-authorize guests, and keep a searchable history of everyone who comes through your gates.</p>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-4">
                            <div class="feature-card h-100">
                                <div class="feature-icon"><i class="bi bi-house-door"></i></div>
                                <h4>Household Intelligence</h4>
                                <p class="text-muted">Maintain real-time records for each home—family members, emergency contacts, lease details, and more—without chasing paper files.</p>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-4">
                            <div class="feature-card h-100">
                                <div class="feature-icon"><i class="bi bi-car-front"></i></div>
                                <h4>Vehicle Access Control</h4>
                                <p class="text-muted">Track resident vehicles, parking permits, and visitor cars with color-coded tags that make checkpoint decisions effortless.</p>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-4">
                            <div class="feature-card h-100">
                                <div class="feature-icon"><i class="bi bi-broadcast"></i></div>
                                <h4>Community Broadcasts</h4>
                                <p class="text-muted">Send bulletins, emergency alerts, and event reminders in seconds—and know every resident received them.</p>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-4">
                            <div class="feature-card h-100">
                                <div class="feature-icon"><i class="bi bi-graph-up-arrow"></i></div>
                                <h4>Actionable Dashboards</h4>
                                <p class="text-muted">View daily metrics, occupancy snapshots, and compliance status so management decisions stay data-driven.</p>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-4">
                            <div class="feature-card h-100">
                                <div class="feature-icon"><i class="bi bi-lock"></i></div>
                                <h4>Security First</h4>
                                <p class="text-muted">Role-based access, audit trails, and secure cloud backups safeguard the information your community trusts us to protect.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <section class="py-5">
                <div class="container">
                    <div class="row g-5 align-items-center">
                        <div class="col-lg-6">
                            <div class="benefits-card shadow-sm">
                                <span class="badge rounded-pill text-uppercase fw-semibold mb-3">Why residents love it</span>
                                <h3 class="mb-3">Designed for everyday peace of mind</h3>
                                <p class="text-muted mb-4">Margosa residents and board members use MyMSBSApp to remove guesswork and keep neighbors in the loop. Here is how your community benefits immediately:</p>
                                <ul class="checklist text-dark">
                                    <li><i class="bi bi-check-circle-fill"></i>Mobile-friendly portal for guards, admins, and residents alike.</li>
                                    <li><i class="bi bi-check-circle-fill"></i>Automated reminders for renewals, dues, and security updates.</li>
                                    <li><i class="bi bi-check-circle-fill"></i>Centralized documents that stay accessible from any device.</li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="row g-4">
                                <div class="col-12">
                                    <div class="feature-card h-100">
                                        <div class="feature-icon"><i class="bi bi-speedometer2"></i></div>
                                        <h4>Launch in days, not months</h4>
                                        <p class="text-muted">We tailored workflows for gated communities, so your team can migrate existing registers quickly and start enjoying streamlined coordination right away.</p>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="feature-card h-100">
                                        <div class="feature-icon"><i class="bi bi-lightbulb"></i></div>
                                        <h4>Guided onboarding</h4>
                                        <p class="text-muted">Step-by-step prompts and contextual tips help every guard and resident become productive on day one.</p>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="feature-card h-100">
                                        <div class="feature-icon"><i class="bi bi-heart-pulse"></i></div>
                                        <h4>Safety by default</h4>
                                        <p class="text-muted">Emergency workflows surface the information first responders need instantly—no binders, no guesswork.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <section class="py-5">
                <div class="container">
                    <div class="row g-4 text-center text-lg-start align-items-center">
                        <div class="col-lg-8">
                            <div class="cta-section">
                                <h2 class="fw-bold">Be the hero of your estate management story</h2>
                                <p class="lead mb-4">Transform fragmented processes into a single, responsive system that keeps Margosa residents informed, secure, and connected.</p>
                                <div class="d-flex flex-wrap gap-3">
                                    <a href="register.jsp" class="btn btn-light text-primary fw-semibold px-4">
                                        <i class="bi bi-rocket-takeoff me-2"></i>Create your account
                                    </a>
                                    <a href="login.jsp" class="btn btn-outline-light fw-semibold px-4">
                                        <i class="bi bi-box-arrow-in-right me-2"></i>Sign in and explore
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 text-lg-center">
                            <div class="feature-card h-100">
                                <div class="feature-icon"><i class="bi bi-award"></i></div>
                                <h4>Built for community success</h4>
                                <p class="text-muted">From visitor management to resident engagement, MyMSBSApp keeps Margosa Estates safer, smarter, and more connected every day.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </main>

        <jsp:include page="includes/footer.html"/>
    </body>
</html>
