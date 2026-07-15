# Algorithm Methodology

Detailed explanation of the Push or Pause readiness calculation.

## Overview

The readiness score combines four physiological and behavioral metrics:

**Formula:**
Readiness Score = (HRV_score × 0.35) + (RHR_score × 0.25) + (Sleep_score × 0.25) + (Training_Load_score × 0.15)

**Recommendation:**
- Score ≥ 65: **PUSH** (ready for hard training)
- Score < 65: **PAUSE** (rest or light activity recommended)

## Quick Summary

This algorithm provides a daily PUSH or PAUSE recommendation by:

1. **Collecting data** from Apple Watch (HRV, RHR, sleep, workouts)
2. **Establishing baselines** for each metric (your normal)
3. **Scoring deviations** from baseline (0-100 for each component)
4. **Weighting components** based on research (HRV 35%, others less)
5. **Generating score** via weighted average
6. **Recommending action** (≥65 = PUSH, <65 = PAUSE)

**Key features:**
- ✅ Adapts to your training level (athlete or casual)
- ✅ Handles missing data gracefully
- ✅ 100% local processing (privacy-first)
- ✅ Research-backed methodology


## Apple Watch Data Sources

This algorithm is designed specifically for Apple Watch + HealthKit:

**Direct from HealthKit:**
| Metric | HealthKit Type | Used For |
|--------|---------------|----------|
| HRV (RMSSD) | heartRateVariabilitySDNN | Recovery assessment |
| Resting Heart Rate | restingHeartRate | Stress indicator |
| Sleep Duration | sleepAnalysis (asleep) | Recovery time |
| Sleep Efficiency | sleepAnalysis (in bed vs asleep) | Sleep quality |
| Workout Data | workoutType | Training load |
| Heart Rate | heartRate | Workout intensity |

**Calculated by App:**
- Training load (from workout data)
- ACWR or recovery timing (based on user pattern)
- 7-day baselines for HRV and RHR
- Component scores and final recommendation

**Privacy commitment:**
- All calculations performed locally on device
- No cloud sync required
- No data leaves your Apple Watch/iPhone
- Open source methodology for verification

---
## Component Calculations

### 1. HRV Score (Weight: 35%)

**Why HRV matters:** Heart Rate Variability reflects autonomic nervous system recovery. Higher HRV indicates better recovery and readiness for stress.

**Calculation:**

1. Establish 7-day rolling baseline (mean RMSSD)
2. Compare today's HRV to baseline
3. Score based on deviation

**Scoring Table:**

| HRV vs Baseline | Deviation | Score | Interpretation |
|----------------|-----------|-------|----------------|
| At or above baseline | 0% or positive | 100 | Excellent recovery |
| Slightly below | 0-10% below | 80 | Good recovery |
| Moderately below | 10-20% below | 60 | Reduced recovery |
| Significantly below | 20-30% below | 40 | Poor recovery |
| Very low | >30% below | 20 | Very poor recovery |

**Research basis:** Plews et al. (2013), Buchheit (2014)

**Note:** Individual HRV baselines vary widely (30-100ms typical). Personal baseline comparison is more meaningful than population norms.

---

### 2. Resting Heart Rate Score (Weight: 25%)

**Why RHR matters:** Elevated resting heart rate indicates cardiovascular stress, inadequate recovery, or onset of illness.

**Calculation:**

1. Establish 7-day rolling baseline (mean morning RHR)
2. Compare today's RHR to baseline
3. Score based on elevation

**Scoring Table:**

| RHR vs Baseline | Elevation | Score | Interpretation |
|----------------|-----------|-------|----------------|
| At or below baseline | 0 or negative | 100 | Well recovered |
| Slightly elevated | 1-5 bpm above | 80 | Normal variation |
| Moderately elevated | 5-10 bpm above | 60 | Caution - possible stress |
| Significantly elevated | 10-15 bpm above | 40 | High stress/poor recovery |
| Very elevated | >15 bpm above | 20 | Very high stress |

**Research basis:** Achten & Jeukendrup (2003), Hynynen et al. (2006)

**Note:** Morning RHR most stable. Individual baselines range from 40-80 bpm in healthy adults.

---

### 3. Sleep Score (Weight: 25%)

**Why sleep matters:** Sleep is the primary recovery mechanism for physical and mental restoration. Both quantity and quality matter.

**Calculation:**

Sleep score combines two equally-weighted components:

#### Duration Component (50% of sleep score):

| Sleep Duration | Score | Interpretation |
|---------------|-------|----------------|
| ≥8 hours | 100 | Optimal |
| 7-8 hours | 80 | Good |
| 6-7 hours | 60 | Adequate |
| 5-6 hours | 40 | Insufficient |
| <5 hours | 20 | Severely insufficient |

#### Efficiency Component (50% of sleep score):

**Sleep Efficiency = (Time Asleep / Time in Bed) × 100**

| Sleep Efficiency | Score | Interpretation |
|-----------------|-------|----------------|
| ≥90% | 100 | Excellent |
| 85-90% | 80 | Good |
| 75-85% | 60 | Fair |
| 65-75% | 40 | Poor |
| <65% | 20 | Very poor |

**Final Sleep Score = (Duration Score + Efficiency Score) / 2**

**Example:**
- 7.5 hours sleep (Duration score: 80)
- 88% efficiency (Efficiency score: 80)
- Final Sleep Score: (80 + 80) / 2 = **80 points**

**Research basis:** Fullagar et al. (2015), Halson (2014), Vitale et al. (2019)

---

### 4. Training Load Score (Weight: 15%)

**Why training load matters:** Recent training volume affects recovery needs. High loads without adequate rest increase fatigue and injury risk.

**Challenge:** Apple Watch users range from elite athletes to casual exercisers. Our algorithm adapts to your pattern.

---

#### Foundation: Workout Intensity Calculation

All training load methods use these standardized measurements:

**Heart Rate Intensity Zones:**

Based on percentage of maximum heart rate (default: 220 - age):

| Zone | % of Max HR | Intensity Multiplier | Description |
|------|-------------|---------------------|-------------|
| Light | <60% | 0.5x | Recovery/easy pace |
| Moderate | 60-75% | 1.0x | Aerobic training |
| Hard | 75-85% | 1.5x | Tempo/threshold |
| Very Hard | 85-95% | 2.0x | VO2 max intervals |
| Maximum | >95% | 2.5x | All-out efforts |

**Workout Type Multipliers:**

| Workout Type | Multiplier | Examples | Recovery Notes |
|-------------|-----------|----------|----------------|
| Running/Cycling | 1.0x | Road running, cycling | Primarily cardiovascular |
| HIIT/Functional | 1.3x | CrossFit, HIIT, circuits | High intensity, mixed demands |
| Strength Training | 1.2x | Weightlifting, resistance | Neuromuscular stress, may require 48-72hr recovery |
| Low Impact | 0.5x | Yoga, walking, hiking | Minimal stress |

**Note on Strength Training:**
Traditional training load metrics (duration × heart rate) underestimate strength training 
stress because:
- Heart rate doesn't capture neuromuscular fatigue
- Muscle damage recovery takes 24-72 hours independent of cardiovascular stress
- Heavy compound lifts (squat, deadlift, bench) particularly taxing

We apply 1.2x multiplier as partial correction, but heavy strength days may still 
show artificially low training load scores. Consider manual workout intensity tagging 
for better accuracy.

**Maximum Heart Rate:**
- Default calculation: 220 - age
- User can manually override if known from testing

---

#### Adaptive Calculation Method

The algorithm automatically detects your training pattern and applies appropriate scoring:

##### For Consistent Trainers (4+ workouts/week, 28+ days of data):

**Uses Acute:Chronic Workload Ratio (ACWR)**

1. **Calculate workout stress** for each session:
- Workout Stress = Duration (min) × Intensity Multiplier × Type Multiplier

2. **Sum stress scores:**
- Acute Load = Sum of last 7 days
- Chronic Load = Sum of last 28 days
- ACWR = Acute Load / Chronic Load

3. **Score based on ratio:**

| ACWR Ratio | Score | Interpretation |
|-----------|-------|----------------|
| 0.8-1.3 | 100 | Optimal training zone |
| 1.3-1.5 or 0.5-0.8 | 80 | Caution zone |
| 1.5-2.0 or 0.3-0.5 | 60 | Elevated risk |
| >2.0 or <0.3 | 40 | High risk or detraining |

**Research basis:** Gabbett (2016) - ACWR >1.5 associated with 2-4x injury risk

---

##### For Casual Exercisers (1-3 workouts/week):

**Uses recovery time since last hard effort**

Hard workout defined as: Duration >30 min AND Average HR >75% max

| Time Since Hard Workout | Score | Interpretation |
|------------------------|-------|----------------|
| 3+ days | 100 | Fully recovered |
| 2 days | 85 | Good recovery |
| 1 day | 70 | Partial recovery |
| <24 hours | 60 | Acute fatigue likely |
| No hard workouts in 7 days | 100 | Well rested |

**Research basis:** Kellmann et al. (2018) - Most individuals need 48-72 hours between hard sessions

---

##### For New Users (<28 days of data):

**Simplified approach based on recent activity**

| Recent Activity | Score | Interpretation |
|----------------|-------|----------------|
| No workout in 48 hours | 100 | Rested |
| Moderate workout in 24 hours | 85 | Light fatigue |
| Hard workout in 24 hours | 70 | Moderate fatigue |

Moderate workout: <75% max HR or <30 min duration  
Hard workout: ≥75% max HR and ≥30 min duration

---

#### Missing Data Handling

- **No workout data available:** Training Load component excluded from calculation
- **Other components automatically re-weighted** proportionally
- **Minimum 7 days needed** for ACWR approach (otherwise falls back to simpler method)

**Example:** If Training Load excluded:
- Readiness = (HRV × 0.41) + (RHR × 0.29) + (Sleep × 0.29)
- (Weights rescaled to sum to 1.0)

---

## Threshold Rationale

### Why 65?

This cutpoint is preliminary and will be refined through validation.

**Current reasoning:**
- Score <65 indicates majority of metrics below optimal
- Conservative threshold prioritizes recovery over performance
- Binary decision (PUSH/PAUSE) reduces decision fatigue
- Simple mental model for users

**Validation needed:**
- User feedback during beta testing
- Correlation with subjective readiness ratings
- Performance outcome tracking
- Injury/illness prevention effectiveness

**Future refinements planned:**
- Three-tier system (PUSH / CAUTION / PAUSE)
- Individual calibration based on user history
- Machine learning to optimize threshold per user
- Context-aware adjustments (competition season, base building, etc.)

---

## Edge Cases & Limitations

### Missing Data Scenarios

**If one component missing:**
- Algorithm excludes that component
- Remaining components re-weighted proportionally
- Minimum 2 components required for calculation

**If multiple components missing:**
- Calculation not performed
- User notified to wear Apple Watch consistently
- Historical trend shown instead

### Known Limitations

1. **Individual variability**
   - Baselines vary significantly between individuals
   - Population norms not applicable
   - Requires 7+ days to establish personal baseline

2. **Context ignorance**
   - Doesn't account for life stress (work, relationships)
   - Cannot detect illness until physiological changes appear
   - No awareness of nutrition, hydration, or other lifestyle factors

3. **Sport specificity**
   - Training load calculation may need adjustment for different sports
   - Weightlifters vs endurance athletes have different recovery profiles
   - Currently uses generalized approach

4. **No validation yet**
   - Algorithm pending real-world testing
   - Weightings based on research but not validated in this specific combination
   - User feedback will inform refinements

### Planned Improvements

**Near-term (Beta phase):**
- Illness detection algorithm (sudden HRV drop + elevated RHR pattern)
- Menstrual cycle tracking option for female athletes
- Manual override with reason tracking (for algorithm learning)

**Medium-term (Post-launch):**
- **Strength training intensity detection** (heavy/moderate/light based on user input)
- **Workout-specific recovery windows** (72hrs for heavy squats vs 24hrs for cardio)
- Training phase awareness (base building vs taper vs competition)
- Sport-specific tuning (runner vs CrossFit vs powerlifter)
- Trend analysis and pattern recognition

**Long-term (Future versions):**
- Machine learning to personalize component weights
- Integration with subjective readiness surveys
- Predictive analytics (illness/injury risk forecasting)
- Advanced strength training metrics (volume load, bar velocity if available)

---

## Implementation Notes

### User Pattern Detection

Algorithm automatically categorizes users:
Workout frequency = Count of workouts in last 28 days / 4

If frequency ≥ 4 workouts/week → Consistent Trainer (use ACWR)
If frequency 1-3 workouts/week → Casual Exerciser (use recovery time)
If <28 days of data → New User (use simplified method)

Pattern re-evaluated weekly to adapt to changing habits.

### Data Storage Requirements

**Local storage (CoreData or similar):**
- Daily component scores (HRV, RHR, Sleep, Training Load)
- Daily readiness scores and recommendations
- 28-day workout history (for ACWR calculation)
- User baselines (rolling 7-day averages)
- User preferences (manual max HR, etc.)

**Not stored:**
- Raw HealthKit data (queried on-demand)
- Cloud backups (unless user opts in via iCloud)
- Any identifiable information

### Cold Start Handling

**Day 1-6:**
- No baseline available
- Show data collection screen
- Explain "building your baseline"
- No recommendation given

**Day 7+:**
- Baseline established for HRV and RHR
- Recommendations begin
- Marked as "preliminary" until day 14

**Day 28+:**
- Full ACWR calculation available (if applicable)
- Algorithm fully functional

---

## Example Calculation

**Sample user data for today:**

| Component | Today's Value | Baseline | Calculation | Score |
|-----------|--------------|----------|-------------|-------|
| HRV | 45ms | 50ms | 10% below baseline | 80 |
| RHR | 52 bpm | 48 bpm | 4 bpm above baseline | 80 |
| Sleep Duration | 7.5 hrs | - | 7-8 hour range | 80 |
| Sleep Efficiency | 88% | - | 85-90% range | 80 |
| Training Load | ACWR 1.1 | - | Optimal zone (0.8-1.3) | 100 |

**Component scores:**
- HRV: 80
- RHR: 80
- Sleep: (80 + 80) / 2 = 80
- Training Load: 100

**Final calculation:**
Readiness = (80 × 0.35) + (80 × 0.25) + (80 × 0.25) + (100 × 0.15)
= 28 + 20 + 20 + 15
= 83
**Recommendation: PUSH** (score ≥ 65)

---
## HRV Data Sourcing Strategy (Sleep vs. Waking Fallback)

### The Principle
Heart Rate Variability (HRV) is our primary metric for measuring autonomic nervous system recovery (weighted at 35% of the overall Readiness Score). To balance scientific accuracy with a seamless, frustration-free user experience, the algorithm uses a dual-sourcing strategy.

### 1. Primary Source: The Sleep Window (Preferred)
* **What it is:** The average of HRV samples recorded specifically while the user is asleep.
* **HealthKit Sleep Identifier:** `HKCategoryTypeIdentifier.sleepAnalysis`
  * *Note: We filter specifically for samples matching the value `.asleep` (which includes core, deep, and REM sleep phases) to establish the boundary of the sleep window, ignoring simple "in bed" awake time.*
* **HealthKit HRV Identifier:** `HKQuantityTypeIdentifier.heartRateVariabilitySDNN` (restricted to the sleep start/end timestamps).
* **Why we use it:** Sleeping HRV represents the absolute gold-standard baseline. During sleep, external variables like emotional stress, physical movement, and caffeine intake are entirely removed, giving us the most accurate view of true physical recovery.
* **Limitations:** Requires the user to wear their Apple Watch to bed and have active sleep data.

### 2. Fallback Source: 24-Hour Average
* **What it is:** The average of all HRV samples recorded over the last 24 hours.
* **HealthKit HRV Identifier:** `HKQuantityTypeIdentifier.heartRateVariabilitySDNN` (queried globally over a `Date()` range of `now` minus 24 hours).
* **Why we use it:** If a user charges their watch overnight, forgets to wear it, or sleep tracking fails, we do not want the app's core calculation to break. This fallback ensures the user *always* gets a Readiness Score.
* **Limitations:** Waking HRV is inherently noisier. It can be heavily skewed by recent activity, stress, digestion, or coffee.

### User Interface Transparency
Because the data quality of these two sources is different, the app will explicitly display which method was used:
* 🟢 **"Sleep HRV"** (High Precision) – Displayed when the sleep window is successfully used.
* 🟡 **"Waking HRV"** (Approximate) – Displayed during fallback, accompanied by a gentle reminder: *"For maximum accuracy, wear your watch to sleep tonight."*

## References

Full citations and literature review available in [/research/literature-review.md](../research/literature-review.md)

---

## Version History

- v0.1 (Current): Initial methodology documentation
- Future: Validation testing and refinement

*Last updated: [2026-07-14]*
