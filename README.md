# Music Theory Trivia

A trivia game for learning and practicing music theory.

## Overview

This game allows users to interact with musical notes on a staff and answer questions about music theory. The application features a JavaScript frontend using VexFlow for musical notation rendering, and a Python Flask backend providing a REST API for trivia questions.

## Repository Structure

```
music-theory-trivia/
├── frontend/
│   ├── index.html      # Main webpage
│   ├── script.js       # Game logic and VexFlow integration
│   └── styles.css      # UI styling
├── backend/
│   ├── app.py          # Flask REST API server
│   └── requirements.txt # Python dependencies
└── README.md
```

## Features

- **Musical Staff Rendering**: Uses VexFlow library to display musical notation
- **Interactive Trivia**: Answer questions about scales, intervals, and music theory concepts
- **Real-time Feedback**: Immediate feedback on answer correctness
- **Score Tracking**: Keep track of your correct answers
- **REST API**: Backend API for question generation and answer validation

## Getting Started

### Prerequisites

- Python 3.8 or higher
- A modern web browser (Chrome, Firefox, Safari, Edge)
- (Optional) A local web server for development

### Backend Setup

1. Navigate to the backend directory:
   ```bash
   cd backend
   ```

2. Create a virtual environment (recommended):
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

4. Run the Flask server:
   ```bash
   python app.py
   ```

   The API will be available at `http://localhost:5000`

   For development with debug mode enabled:
   ```bash
   FLASK_DEBUG=true python app.py
   ```

### Frontend Setup

1. The frontend can be served using any static file server, or simply open `frontend/index.html` in a browser.

2. For development with a local server:
   ```bash
   cd frontend
   python -m http.server 8080
   ```

   Then open `http://localhost:8080` in your browser.

**Note**: The frontend includes mock data for offline use. When the backend API is not available, the game will use local mock questions.

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/` | API information |
| GET | `/health` | Health check |
| GET | `/api/question` | Get a random trivia question |
| POST | `/api/answer` | Submit an answer |
| GET | `/api/questions` | Get all questions (without answers) |

### Example API Usage

**Get a question:**
```bash
curl http://localhost:5000/api/question
```

**Submit an answer:**
```bash
curl -X POST http://localhost:5000/api/answer \
  -H "Content-Type: application/json" \
  -d '{"question_id": 1, "answer": "G"}'
```

## Development

### Adding New Questions

Questions can be added to the `QUESTIONS` list in `backend/app.py`. Each question should have:
- `id`: Unique identifier
- `question`: The question text
- `options`: Array of possible answers
- `correct_answer`: The correct answer
- `notes`: Array of VexFlow note strings (e.g., `['C/4', 'E/4', 'G/4']`)

### Customizing the UI

The UI is styled using CSS in `frontend/styles.css`. The design uses a dark theme with accent colors that can be easily modified.

## License

This project is open source and available under the MIT License.
