
# Push or Pause

**Open source algorithm for training readiness. Early stage development.**

---

## The Concept

Every morning: Should you **Push** (train hard) or **Pause** (rest)?

We're building an algorithm that answers this based on:
- **Heart Rate Variability (HRV)** - Autonomic nervous system recovery
- **Resting Heart Rate (RHR)** - Cardiovascular stress indicator  
- **Sleep Quality** - Duration and efficiency
- **Training Load** - Recent workout strain

**Transparent methodology. Privacy-first. No subscription.**

---

## Status: Early Development

⚠️ **This is very early stage.** Here's what exists and what doesn't:

**What exists now:**
- ✅ Project vision and goals
- ✅ Research compilation (in progress)
- ✅ Algorithm framework (in progress)

**What doesn't exist yet:**
- ❌ No working code yet
- ❌ No iOS app yet
- ❌ No validation studies yet

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

---

## Research Foundation

*Note: Full literature review in progress. Preliminary sources listed below.*

This algorithm is based on established research in exercise physiology:

**Heart Rate Variability:**
- Buchheit, M. (2014). Monitoring training status with HR measures
- Plews, D. J., et al. (2013). Training adaptation and heart rate variability

**Sleep & Recovery:**
- Fullagar, H. H., et al. (2015). Sleep and athletic performance

**Training Load:**
- Foster, C., et al. (2001). Monitoring exercise training

Detailed analysis and citations: *(coming soon)*

---

## Algorithm Overview (Preliminary)

**Very simple version:**
Readiness = (HRV_score × 0.35) + (RHR_score × 0.25) + (Sleep_score × 0.25) + (Training_Load_score × 0.15)

If Score ≥ 65: PUSH (ready for hard training)
If Score < 65: PAUSE (rest or light activity)

**Component calculations:**
- HRV Score: Current HRV relative to 7-day baseline
- RHR Score: Current RHR relative to 7-day baseline
- Sleep Score: Duration, efficiency, quality
- Training Load Score: Acute (7-day) vs Chronic (28-day) training load ratio

Detailed methodology: *(coming soon)*

Detailed methodology: *(coming soon)*

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
