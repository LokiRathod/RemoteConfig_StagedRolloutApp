# Remote Config Rollout Demo

## Project Title
Remote Config Rollout Demo

## Platform Choice
This project is built with Flutter and Dart so the same architecture can be demonstrated across iOS, Android, desktop, and web from one codebase.

## Assignment Summary
This app demonstrates how a remote-config platform can safely control runtime features without shipping separate builds. It focuses on deterministic staged rollout, kill-switch behavior, safe fallback logic, and a decision engine that stays independent from the UI.

## How The App Demonstrates Remote Config And Staged Rollout
- Config A and Config B are mocked configuration objects inside the app.
- The same build can switch between configs at runtime.
- Features are decided by a reusable `FeatureGateService`.
- Percentage rollout is deterministic and based on `stableHash(userId + featureKey) % 100`.
- A kill-switch disables features immediately, even if the flag is enabled and rollout is 100%.
- Invalid or unknown config fails closed and disables the feature safely.

## Architecture Overview
The app follows MVVM with Riverpod for dependency wiring and state composition.

## Architecture Diagram
```text
+-------------------------+
| Mock Config A / B       |
+-----------+-------------+
            |
            v
+-------------------------+
| RemoteConfigRepository  |
+-----------+-------------+
            |
            v
+-------------------------+
| ConfigValidator         |
+-----------+-------------+
            |
            v
+-------------------------+
| FeatureGateService      |
| + RolloutEvaluator      |
+-----------+-------------+
            |
            v
+-------------------------+
| HomeViewModel           |
| Riverpod Providers      |
+-----------+-------------+
            |
            v
+-------------------------+
| Flutter UI              |
| Gated Widgets           |
+-------------------------+
```

## MVVM + Riverpod Explanation
- Model: `RemoteConfigModel`, `FeatureFlagConfig`, and `FeatureDecision`
- ViewModel: `HomeViewModel` prepares config state and feature decisions for the UI
- View: Flutter widgets only render state and forward user actions
- Repository: `MockRemoteConfigRepository` selects Config A or Config B
- Service: `ConfigValidator`, `RolloutEvaluator`, and `FeatureGateService`
- Riverpod: wires dependencies and keeps UI logic light

## Remote Config Model Explanation
`RemoteConfigModel` contains the top-level config version, environment, and feature map. `FeatureFlagConfig` stores flag metadata such as `enabled`, `killSwitch`, `rolloutPercentage`, allow/block lists, `variant`, `owner`, and `expiryDate`. `FeatureDecision` is the explainable output consumed by the UI and debug panel.

## Feature Decision Priority
The feature decision engine follows this order exactly:
1. Unknown feature disables safely.
2. Invalid config disables safely.
3. Kill-switch disables immediately.
4. `enabled = false` disables the feature.
5. `blockedUserIds` disables the user.
6. `allowedUserIds` enables the user.
7. Deterministic percentage rollout decides the final state.

## Deterministic Rollout Explanation
Rollout is never random. Each user-feature pair is assigned a stable bucket using a small deterministic hash. That means the same user always receives the same result for the same feature unless the config changes.

## Kill-Switch Behavior
Kill-switch takes top priority after validation. If `killSwitch = true`, the feature is disabled immediately regardless of rollout percentage or allow-list membership.

## Safe Fallback Behavior
The system fails closed.
- Unknown feature: disabled safely
- Invalid config: disabled safely
- Malformed rollout values: disabled safely
- UI never crashes because rollout logic stays in the service layer

## How To Run The App
```bash
flutter pub get
flutter run
```

## How To Run Tests
```bash
flutter test
```

## How To Switch Config A And Config B
Use the `Config Switcher` segmented control on the home screen. The screen updates immediately because the selected config is stored in Riverpod state and re-evaluated through the decision engine.

## Example Decisions For Sample User `user_123`
- `market_news_card` is enabled in Config A because rollout is 100% and disabled in Config B because the feature flag is off.
- `new_portfolio_dashboard` is disabled in Config B because the kill-switch overrides all other rules.
- `quick_invest_button` shows how the same user can see different outcomes when rollout percentage changes from 25% to 100%.
- The debug panel displays the exact bucket, reason, rollout percentage, kill-switch state, and variant for every feature.

## Trade-Offs
- Mock config over real backend: chosen to keep the exercise focused on architecture and decision logic.
- Simple stable hash over production hashing: chosen for readability and testability.
- Riverpod over a heavier state solution: chosen for dependency injection and composable state.
- Fail-closed over fail-open: chosen because production safety matters more than temporary feature availability.

## AI Usage Summary
AI helped generate boilerplate, suggest structure, draft tests, and improve documentation wording. The final architecture, rollout strategy, decision ordering, kill-switch priority, fail-closed behavior, and safety framing are intentionally explicit and explainable.

## What I Would Improve With One More Day
- Real remote config backend integration
- Signed config verification
- Last-known-good config cache
- Schema version migration support
- Admin dashboard and audit logs
- Experiment analytics and automatic rollback signals
- More widget and integration coverage
- Targeting by app version, platform, country, and cohort

## Adoption And Safety At Scale
A safe rollout platform needs more than a boolean flag.
- Each flag should have an owner, expiry date, and clear purpose.
- Config publishing should be gated by schema validation.
- Rollouts should advance gradually: 1%, 5%, 10%, 25%, 50%, 100%.
- Risky features should always have a kill-switch.
- The SDK should fail closed when config is invalid.
- Unknown flags should never enable themselves implicitly.

## Metrics To Decide Rollout Advancement
- Crash-free sessions
- Error rate
- API failure rate
- Latency
- App startup time
- Frame drops and jank
- Conversion rate
- Transaction failure rate
- User engagement
- Support tickets
- Sentry issues
- Analytics events
- Order placement failures
- Portfolio refresh failures
- Price update latency
- Payment or transaction drop-offs
- WebSocket disconnect rate

## Flag Debt Management
- Every flag should have an owner and expiry date.
- Fully rolled out flags should be removed from code.
- A dashboard should highlight stale or expired flags.
- CI can warn or fail on expired flags.
- Naming conventions should stay documented.
- Teams should review flags regularly instead of letting them become permanent accidental configuration.
