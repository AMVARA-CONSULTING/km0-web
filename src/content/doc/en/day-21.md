---
title: "Day 21 - Meetup: data and autonomous driving"
description: "At Casino del Masnou we walked through autonomy levels, sensors, and why training data dominates autonomous cars."
pubDate: 2026-08-07
locale: en
---

At the [7 August meetup](/en/meeting/) at Casino del Masnou we talked about **autonomous driving and data**. It was not a product pitch: it was a table talk on which level we are really at, and why training these systems burns absurd amounts of information.

## Which levels exist (and where we are)

The SAE scale runs from **0 to 5**. Useful summary:

- **Level 0:** the human does everything.
- **Level 1 and 2:** assistance (lane keep, adaptive cruise). The driver stays responsible. That is where most street cars live, including Tesla Autopilot / Full Self-Driving in daily use: you cannot leave the wheel for long or the car warns and eventually brakes.
- **Level 3:** the car can drive in bounded conditions (for example highway, up to a speed limit). Mercedes reached that with Drive Pilot on the S-Class; liability in that mode sits with the maker. The package is expensive (duplicated sensors for safety) and commercial uptake has stalled.
- **Level 4:** high automation in a defined domain. **Waymo**-style robotaxis in some US cities run with no driver on board.
- **Level 5:** anywhere, any condition. Still not a consumer product.

For the average buyer today, the realistic ceiling remains **level 2**. Anyone aiming at 4 needs another scale of sensors and compute.

## Two sensor philosophies

Two clear approaches:

1. **Mostly cameras** (Tesla-style): cheaper, but fragile in fog, heavy rain, low sun, or night.
2. **Sensor fusion** (cameras + lidar + radar, like Waymo): more robust and far more expensive to build and keep in sync.

A lidar “sees” hundreds of metres; several lidars, radars, and a dozen cameras generate **terabytes per day per car**. Syncing those signals in real time is a computer on wheels, not an add-on.

## Data, rules, and AI

Fleets already on the road (especially Tesla) pile up miles every day; that feeds training. Whoever does not keep that telemetry at scale cannot compete on driving models.

Mercedes built much of level 3 with **hand-written rules** (hundreds of thousands of lines of C) before generative AI was everyday. Parts of the industry are pausing level 3, staying on 2, and looking at 4 with neural nets: throw away rule code and train again. Training costs city-scale data-centre power; putting the model in the car remains the bottleneck.

## Close

If you care about the conversation (data, AI, or how we run KM0), come to the next [meetup](/en/meeting/). Between meetups, Cloud and Mail stay in the [EU](/en/#services).
