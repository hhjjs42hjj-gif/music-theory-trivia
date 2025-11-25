"""
Music Theory Trivia - Flask Backend

This module provides REST API endpoints for the Music Theory Trivia game.
It handles:
- Generating random trivia questions about music theory
- Validating user answers
- Managing game sessions
"""

import random
from flask import Flask, jsonify, request
from flask_cors import CORS

app = Flask(__name__)
CORS(app)  # Enable CORS for frontend communication

# Music theory trivia questions database
QUESTIONS = [
    {
        'id': 1,
        'question': 'Identify the tonic note in the G major scale.',
        'options': ['G', 'D', 'C', 'E'],
        'correct_answer': 'G',
        'notes': ['G/4', 'A/4', 'B/4', 'C/5', 'D/5', 'E/5', 'F#/5', 'G/5']
    },
    {
        'id': 2,
        'question': 'What is the 5th note (dominant) in the C major scale?',
        'options': ['E', 'F', 'G', 'A'],
        'correct_answer': 'G',
        'notes': ['C/4', 'D/4', 'E/4', 'F/4', 'G/4', 'A/4', 'B/4', 'C/5']
    },
    {
        'id': 3,
        'question': 'Which note is the mediant (3rd degree) in the D major scale?',
        'options': ['E', 'F#', 'G', 'A'],
        'correct_answer': 'F#',
        'notes': ['D/4', 'E/4', 'F#/4', 'G/4', 'A/4', 'B/4', 'C#/5', 'D/5']
    },
    {
        'id': 4,
        'question': 'What interval is between C and G?',
        'options': ['Perfect 4th', 'Perfect 5th', 'Major 3rd', 'Minor 6th'],
        'correct_answer': 'Perfect 5th',
        'notes': ['C/4', 'G/4']
    },
    {
        'id': 5,
        'question': 'Which note is the leading tone in the A major scale?',
        'options': ['G', 'G#', 'F#', 'E'],
        'correct_answer': 'G#',
        'notes': ['A/4', 'B/4', 'C#/5', 'D/5', 'E/5', 'F#/5', 'G#/5', 'A/5']
    },
    {
        'id': 6,
        'question': 'What is the relative minor of C major?',
        'options': ['A minor', 'E minor', 'D minor', 'B minor'],
        'correct_answer': 'A minor',
        'notes': ['A/4', 'B/4', 'C/5', 'D/5', 'E/5', 'F/5', 'G/5', 'A/5']
    },
    {
        'id': 7,
        'question': 'Which note is the subdominant (4th degree) in the F major scale?',
        'options': ['A', 'Bb', 'C', 'D'],
        'correct_answer': 'Bb',
        'notes': ['F/4', 'G/4', 'A/4', 'Bb/4', 'C/5', 'D/5', 'E/5', 'F/5']
    },
    {
        'id': 8,
        'question': 'What interval is a half step above C?',
        'options': ['C#/Db', 'D', 'B', 'E'],
        'correct_answer': 'C#/Db',
        'notes': ['C/4', 'C#/4']
    },
    {
        'id': 9,
        'question': 'How many sharps are in the key of D major?',
        'options': ['1', '2', '3', '4'],
        'correct_answer': '2',
        'notes': ['D/4', 'E/4', 'F#/4', 'G/4', 'A/4', 'B/4', 'C#/5', 'D/5']
    },
    {
        'id': 10,
        'question': 'Which chord is built on the 5th degree of a major scale?',
        'options': ['Major', 'Minor', 'Diminished', 'Augmented'],
        'correct_answer': 'Major',
        'notes': ['G/4', 'B/4', 'D/5']
    }
]

# Store for tracking answered questions in a session (simplified)
answered_questions = {}


@app.route('/')
def home():
    """Home route returning API information."""
    return jsonify({
        'name': 'Music Theory Trivia API',
        'version': '1.0.0',
        'endpoints': {
            'GET /api/question': 'Get a random trivia question',
            'POST /api/answer': 'Submit an answer and check if correct',
            'GET /api/questions': 'Get all available questions',
            'GET /health': 'Health check endpoint'
        }
    })


@app.route('/health')
def health():
    """Health check endpoint."""
    return jsonify({'status': 'healthy'})


@app.route('/api/question', methods=['GET'])
def get_question():
    """
    Get a random trivia question.
    
    Returns:
        JSON object containing:
        - id: Question ID
        - question: The trivia question text
        - options: List of possible answers
        - notes: Array of notes to display on the staff
    """
    question = random.choice(QUESTIONS)
    
    # Return question without the correct answer
    return jsonify({
        'id': question['id'],
        'question': question['question'],
        'options': question['options'],
        'notes': question['notes']
    })


@app.route('/api/answer', methods=['POST'])
def submit_answer():
    """
    Submit and validate an answer.
    
    Expected JSON body:
        - question_id: ID of the question being answered
        - answer: The user's selected answer
    
    Returns:
        JSON object containing:
        - correct: Boolean indicating if answer is correct
        - correct_answer: The correct answer
        - next_question: The next question (optional)
    """
    data = request.get_json()
    
    if not data:
        return jsonify({'error': 'No data provided'}), 400
    
    question_id = data.get('question_id')
    user_answer = data.get('answer')
    
    if question_id is None or user_answer is None:
        return jsonify({'error': 'Missing question_id or answer'}), 400
    
    # Find the question
    question = next((q for q in QUESTIONS if q['id'] == question_id), None)
    
    if not question:
        return jsonify({'error': 'Question not found'}), 404
    
    # Check if answer is correct
    is_correct = user_answer == question['correct_answer']
    
    # Get next question (different from current)
    available_questions = [q for q in QUESTIONS if q['id'] != question_id]
    next_question = random.choice(available_questions) if available_questions else None
    
    response = {
        'correct': is_correct,
        'correct_answer': question['correct_answer']
    }
    
    # Include next question data if available
    if next_question:
        response['next_question'] = {
            'id': next_question['id'],
            'question': next_question['question'],
            'options': next_question['options'],
            'notes': next_question['notes']
        }
    
    return jsonify(response)


@app.route('/api/questions', methods=['GET'])
def get_all_questions():
    """
    Get all available questions (without answers).
    
    Returns:
        JSON array of all questions
    """
    questions_without_answers = []
    for q in QUESTIONS:
        questions_without_answers.append({
            'id': q['id'],
            'question': q['question'],
            'options': q['options'],
            'notes': q['notes']
        })
    
    return jsonify({
        'total': len(questions_without_answers),
        'questions': questions_without_answers
    })


if __name__ == '__main__':
    app.run(debug=True, port=5000)
