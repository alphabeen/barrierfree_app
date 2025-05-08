# HangulTalk – Flutter Text Simplification App

HangulTalk is a simple Flutter 3.x sample application that demonstrates a text input -> “easy words” conversion -> result display flow, with a placeholder for OCR. The app currently uses dummy data for conversion (no actual API calls) but is structured to allow adding real services later.

## Features

- **Text Simplification (Dummy)**: Users can input text and press a button to convert it into simpler language. The app uses a dummy service (`TextSimplifyService`) to simulate this conversion. The result is shown on a separate screen.
- **OCR (Planned)**: The app has an OCR screen accessible via a button. Currently, it’s just a placeholder (a button that doesn’t do anything). The code is structured with this separate screen and includes comments, so that in the future one can integrate OCR (for example, using Google ML Kit).

## Project Structure

