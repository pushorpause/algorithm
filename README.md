
# Push or Pause - Algorithm

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**Open source algorithm for daily training readiness assessment. Early stage development.**

---

## What This Is

Complete methodology documentation for the Push or Pause readiness algorithm. This repo contains the transparent, research-backed approach used in a future commercial app.

**App website:** [pushorpause.com](https://pushorpause.com)

---

## Algorithm Overview

**Daily readiness score based on four metrics:**

| Component | Weight | Data Source |
|-----------|--------|-------------|
| Heart Rate Variability (HRV) | 35% | Apple Watch |
| Resting Heart Rate (RHR) | 25% | Apple Watch |
| Sleep Quality | 25% | Apple Watch |
| Training Load | 15% | Calculated from workout data |

**Output:** 
- Score ≥65 → **PUSH** (ready for hard training)
- Score <65 → **PAUSE** (rest or light activity)

**Full details:** [methodology.md](methodology.md)

---
## Repository Contents

### Available Now:
- **[methodology.md](methodology.md)** - Complete algorithm documentation and calculations

### Coming Soon:
- `/research` - Literature review and research citations
- `/reference-implementation` - Python reference code
- `/docs` - FAQ, privacy approach, and additional documentation

---

## Key Features

- **Adapts to user type** - Different calculations for athletes vs casual exercisers
- **Handles missing data** - Graceful degradation when metrics unavailable
- **Privacy-first** - All calculations performed locally on device
- **Apple Watch compatible** - Built specifically for HealthKit data
- **Research-backed** - Citations throughout methodology

## Research Foundation

*Note: Full literature review in progress. Core sources below.*

This algorithm is based on established research in exercise physiology:

**Heart Rate Variability:**
- Buchheit, M. (2014). Monitoring training status with HR measures
- Plews, D. J., et al. (2013). Training adaptation and heart rate variability

**Sleep & Recovery:**
- Fullagar, H. H., et al. (2015). Sleep and athletic performance
- Halson, S. L. (2014). Sleep in elite athletes

**Training Load:**
- Gabbett, T. J. (2016). The training-injury prevention paradox
- Blanch & Gabbett (2016). Has the athlete trained enough to return to play safely?

**Resting Heart Rate:**
- Achten, J., & Jeukendrup, A. E. (2003). Heart rate monitoring applications

*Detailed analysis and full citations coming soon in `/research` folder*

---

## Philosophy

- **Transparent** - Open methodology for verification
- **Research-backed** - Citations and rationale provided
- **Privacy-first** - No cloud storage, no subscriptions
- **Educational** - Learn how readiness algorithms work

---

## Why Open Source?

**Transparency over black boxes:**

Most fitness apps use proprietary algorithms you can't verify. We believe you should understand how your readiness score is calculated, with research citations available for review.

**What's open vs closed:**
- ✅ Algorithm methodology (this repo) - **Open source**
- ✅ Research foundation - **Documented**
- ❌ iOS app implementation - **Private** (commercial product)
- ❌ User data - **Never leaves your device** (privacy-first)

---

## Roadmap

**Phase 1: Foundation** *(Current)*
- [ ] Document complete algorithm with research citations
- [ ] Build reference implementation (Python)
- [ ] Create test suite with known outputs
- [ ] Seek community feedback on methodology

**Phase 2: Implementation**
- [ ] Swift/iOS implementation
- [ ] HealthKit integration (Apple Watch data)
- [ ] Basic iOS app MVP

**Phase 3: Validation**
- [ ] Beta testing with real users
- [ ] Compare against subjective readiness
- [ ] Refine algorithm based on feedback

**Phase 4: Launch**
- [ ] App Store release
- [ ] One-time purchase pricing
- [ ] Privacy-first architecture


**Note:** This is a nights-and-weekends project. Progress will be gradual.

---

## Status

⚠️ **Early Development** - Algorithm documented, app in development

Follow progress:
- **Website:** [pushorpause.com](https://pushorpause.com)
- **GitHub:** Watch this repo for updates

---

## Contributing

Feedback is highly valued!

**How to contribute:**
- 🐛 Found an issue? Open a GitHub issue
- 💡 Have a methodology suggestion? Open an issue
- 📚 Know relevant research? Share papers via issue
- ❓ Questions about calculations? Ask in issues

**Not currently accepting:**
- Pull requests (early stage)
- Feature requests for app (use website contact)

Code contributions may be welcomed as project matures.

---

## Example Calculation

**Sample day:**
- HRV: 10% below baseline → 80 points
- RHR: 4 bpm above baseline → 80 points
- Sleep: 7.5 hrs, 88% efficiency → 80 points
- Training Load: Optimal (ACWR 1.1) → 100 points

**Readiness Score:** 83 → **PUSH** ✓

*See [methodology.md](methodology.md) for complete scoring system*

---

## License

MIT License - Free for educational and personal use.

See [LICENSE](LICENSE) for details.

**Timeline:** Building in public. Follow for updates.

---

## Why This Project Exists

Personal frustration with existing recovery trackers:

**What they do well:**
- HRV-based training insights
- Daily readiness scores
- Help prevent overtraining

**What frustrates me:**
- Expensive monthly or yearly subscriptions (forever)
- Proprietary algorithms (can't verify the math)
- Health data on corporate servers (privacy concerns)
- Ecosystem lock-in

**What I'm building instead:**
- **Open source** - Verify the math yourself
- **Privacy-first** - Data stays on your device  
- **One-time purchase** - No subscription trap
- **Transparent** - See how it works
- 
