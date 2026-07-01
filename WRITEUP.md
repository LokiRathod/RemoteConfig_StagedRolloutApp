# WRITEUP

## 1. What did I ask AI to do, and what did I write or decide myself?
I used AI to generate boilerplate, suggest structure, create test skeletons, and review README wording. I personally decided the architecture, feature decision priority, deterministic rollout strategy, kill-switch priority, fail-closed behavior, test cases, and the overall platform safety approach.

## 2. Where did I override, correct, or throw away AI output, and why?
AI initially suggested random rollout, and I replaced it with deterministic hash-based rollout because random assignment is not acceptable for staged rollout consistency. AI also mixed UI and feature flag logic together in early suggestions, so I separated that logic into `FeatureGateService` and `HomeViewModel` to keep the UI passive and the decision engine testable. AI originally suggested simple toggles, but I added explicit decision reasons and a debug panel because explainability is important in feature rollout systems. AI also did not prioritize the kill-switch strongly enough, so I made kill-switch override all rollout decisions.

## 3. Biggest trade-offs and alternatives considered
- Mock config vs real backend: I chose mock config because the assignment is evaluating architecture and decision logic, not backend integration.
- Simple stable hash vs production-grade hashing: I chose a readable stable hash for this exercise. In production I would likely standardize on MurmurHash or another well-defined hashing strategy.
- MVVM + Riverpod vs Bloc: I chose Riverpod because it gives me straightforward dependency injection, testability, and simple state composition. Bloc would also be a reasonable option for more event-heavy flows.
- Fail-closed vs fail-open: I chose fail-closed because feature flags can directly affect production safety, especially in a fintech or trading-style app.

## 4. What is missing, or what would I do with another day?
With another day I would add a real remote config backend, config signature verification, a last-known-good config cache, schema version migration support, an admin dashboard, audit logs, experiment analytics, automatic rollback based on crash or error thresholds, more widget and integration tests, production-grade hashing, richer targeting by app version, platform, country, cohort, or segment, and flag cleanup automation.

## 5. Adoption and safety
If I were turning this into a real platform, each feature flag would have an owner, expiry date, description, default value, and kill-switch. All configs would pass schema validation before publishing. Rollout would happen gradually at checkpoints like 1%, 5%, 10%, 25%, 50%, and 100%. Risky features would always have a kill-switch. Invalid config would fail closed. Unknown features would be disabled safely. Changes would be audited. Teams would own cleanup after rollout. A platform team would provide the SDK, dashboard, validation tooling, and rollout metrics.

## 6. Metrics to know rollout is safe
I would watch crash-free sessions, error rate, API failure rate, latency, app startup time, frame drops or jank, conversion rate, transaction failure rate, user engagement, support tickets, Sentry issues, and analytics events. In a trading or fintech-style app I would also watch order placement failures, portfolio refresh failures, price update latency, payment or transaction drop-offs, and WebSocket disconnect rate.

## 7. Avoiding flag debt at scale
To avoid flag debt, every flag should have an owner and expiry date. Completed rollout flags should be removed from code. The dashboard should show stale flags. CI should warn or fail on expired flags. Naming conventions should be documented. Teams should review flags regularly. Feature flags should not quietly become permanent configuration unless they are intentionally promoted into a longer-term config system.
