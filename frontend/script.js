/**
 * Music Theory Trivia - Game Logic
 * 
 * This script handles:
 * - VexFlow musical staff rendering
 * - Interactive note selection
 * - API integration for trivia questions
 * - Game state management
 */

// API Configuration
const API_BASE_URL = 'http://localhost:5000/api';

// Game State
const gameState = {
    score: 0,
    questionsAnswered: 0,
    currentQuestion: null,
    isAnswered: false
};

// DOM Elements
const elements = {
    questionText: document.getElementById('question-text'),
    staffContainer: document.getElementById('staff-container'),
    answerOptions: document.getElementById('answer-options'),
    feedbackContainer: document.getElementById('feedback-container'),
    feedbackText: document.getElementById('feedback-text'),
    startBtn: document.getElementById('start-btn'),
    nextBtn: document.getElementById('next-btn'),
    scoreDisplay: document.getElementById('score'),
    questionsAnsweredDisplay: document.getElementById('questions-answered')
};

/**
 * Initialize VexFlow and render a musical staff with notes
 * @param {Array} notes - Array of note strings to display (e.g., ['C/4', 'E/4', 'G/4'])
 */
function renderStaff(notes = ['C/4', 'D/4', 'E/4', 'F/4', 'G/4', 'A/4', 'B/4', 'C/5']) {
    // Clear existing content
    elements.staffContainer.innerHTML = '';

    // Check if VexFlow is loaded
    if (typeof Vex === 'undefined') {
        elements.staffContainer.innerHTML = '<p style="color: #333;">Loading music notation...</p>';
        return;
    }

    const { Renderer, Stave, StaveNote, Voice, Formatter } = Vex.Flow;

    // Create an SVG renderer and attach it to the staff container
    const renderer = new Renderer(elements.staffContainer, Renderer.Backends.SVG);

    // Configure the rendering context
    renderer.resize(500, 150);
    const context = renderer.getContext();
    context.setFont('Arial', 10);

    // Create a stave at position 10, 20 with width 480
    const stave = new Stave(10, 20, 480);

    // Add a clef and time signature
    stave.addClef('treble');

    // Connect stave to the rendering context and draw
    stave.setContext(context).draw();

    // Create notes from the provided array
    const staveNotes = notes.map(note => {
        return new StaveNote({
            keys: [note],
            duration: 'q'
        });
    });

    // Create a voice in 4/4 and add the notes
    const voice = new Voice({ num_beats: notes.length, beat_value: 4 });
    voice.addTickables(staveNotes);

    // Format and justify the notes
    new Formatter().joinVoices([voice]).format([voice], 400);

    // Render the voice
    voice.draw(context, stave);
}

/**
 * Render answer buttons based on the current question options
 * @param {Array} options - Array of answer options
 */
function renderAnswerOptions(options) {
    elements.answerOptions.innerHTML = '';
    
    options.forEach(option => {
        const button = document.createElement('button');
        button.className = 'answer-btn';
        button.textContent = option;
        button.addEventListener('click', () => handleAnswerSelection(option, button));
        elements.answerOptions.appendChild(button);
    });
}

/**
 * Handle answer selection
 * @param {string} selectedAnswer - The answer selected by the user
 * @param {HTMLElement} selectedButton - The button element that was clicked
 */
async function handleAnswerSelection(selectedAnswer, selectedButton) {
    if (gameState.isAnswered) return;
    
    gameState.isAnswered = true;
    
    // Disable all buttons
    const allButtons = elements.answerOptions.querySelectorAll('.answer-btn');
    allButtons.forEach(btn => btn.disabled = true);
    
    // Mark selected button
    selectedButton.classList.add('selected');
    
    try {
        // Submit answer to API
        const result = await submitAnswer(selectedAnswer);
        
        // Update UI based on result
        showFeedback(result.correct, result.correct_answer);
        
        if (result.correct) {
            gameState.score++;
            selectedButton.classList.remove('selected');
            selectedButton.classList.add('correct');
        } else {
            selectedButton.classList.remove('selected');
            selectedButton.classList.add('incorrect');
            
            // Highlight correct answer
            allButtons.forEach(btn => {
                if (btn.textContent === result.correct_answer) {
                    btn.classList.add('correct');
                }
            });
        }
        
        gameState.questionsAnswered++;
        updateScore();
        
        // Show next button
        elements.nextBtn.classList.remove('hidden');
        
    } catch (error) {
        console.error('Error submitting answer:', error);
        showFeedback(false, 'Error occurred');
    }
}

/**
 * Show feedback to the user
 * @param {boolean} isCorrect - Whether the answer was correct
 * @param {string} correctAnswer - The correct answer
 */
function showFeedback(isCorrect, correctAnswer) {
    elements.feedbackContainer.classList.remove('hidden', 'correct', 'incorrect');
    
    if (isCorrect) {
        elements.feedbackContainer.classList.add('correct');
        elements.feedbackText.textContent = '✓ Correct! Great job!';
    } else {
        elements.feedbackContainer.classList.add('incorrect');
        elements.feedbackText.textContent = `✗ Incorrect. The correct answer is: ${correctAnswer}`;
    }
}

/**
 * Hide feedback display
 */
function hideFeedback() {
    elements.feedbackContainer.classList.add('hidden');
    elements.feedbackContainer.classList.remove('correct', 'incorrect');
}

/**
 * Update score display
 */
function updateScore() {
    elements.scoreDisplay.textContent = gameState.score;
    elements.questionsAnsweredDisplay.textContent = gameState.questionsAnswered;
}

/**
 * Fetch a new trivia question from the API
 * @returns {Promise<Object>} Question data
 */
async function fetchQuestion() {
    try {
        const response = await fetch(`${API_BASE_URL}/question`);
        if (!response.ok) {
            throw new Error('Failed to fetch question');
        }
        return await response.json();
    } catch (error) {
        console.warn('API not available, using mock data:', error.message);
        return getMockQuestion();
    }
}

/**
 * Submit an answer to the API
 * @param {string} answer - The user's answer
 * @returns {Promise<Object>} Result data
 */
async function submitAnswer(answer) {
    try {
        const response = await fetch(`${API_BASE_URL}/answer`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                question_id: gameState.currentQuestion.id,
                answer: answer
            })
        });
        
        if (!response.ok) {
            throw new Error('Failed to submit answer');
        }
        
        return await response.json();
    } catch (error) {
        console.warn('API not available, using mock validation:', error.message);
        return validateMockAnswer(answer);
    }
}

/**
 * Mock question data for development/offline use
 */
const mockQuestions = [
    {
        id: 1,
        question: 'Identify the tonic note in the G major scale.',
        options: ['G', 'D', 'C', 'E'],
        correct_answer: 'G',
        notes: ['G/4', 'A/4', 'B/4', 'C/5', 'D/5', 'E/5', 'F#/5', 'G/5']
    },
    {
        id: 2,
        question: 'What is the 5th note (dominant) in the C major scale?',
        options: ['E', 'F', 'G', 'A'],
        correct_answer: 'G',
        notes: ['C/4', 'D/4', 'E/4', 'F/4', 'G/4', 'A/4', 'B/4', 'C/5']
    },
    {
        id: 3,
        question: 'Which note is the mediant (3rd degree) in the D major scale?',
        options: ['E', 'F#', 'G', 'A'],
        correct_answer: 'F#',
        notes: ['D/4', 'E/4', 'F#/4', 'G/4', 'A/4', 'B/4', 'C#/5', 'D/5']
    },
    {
        id: 4,
        question: 'What interval is between C and G?',
        options: ['Perfect 4th', 'Perfect 5th', 'Major 3rd', 'Minor 6th'],
        correct_answer: 'Perfect 5th',
        notes: ['C/4', 'G/4']
    },
    {
        id: 5,
        question: 'Which note is the leading tone in the A major scale?',
        options: ['G', 'G#', 'F#', 'E'],
        correct_answer: 'G#',
        notes: ['A/4', 'B/4', 'C#/5', 'D/5', 'E/5', 'F#/5', 'G#/5', 'A/5']
    }
];

let mockQuestionIndex = 0;

/**
 * Get a mock question for offline/development use
 * @returns {Object} Mock question data
 */
function getMockQuestion() {
    const question = mockQuestions[mockQuestionIndex % mockQuestions.length];
    mockQuestionIndex++;
    return { ...question };
}

/**
 * Validate answer using mock data
 * @param {string} answer - The user's answer
 * @returns {Object} Validation result
 */
function validateMockAnswer(answer) {
    const isCorrect = answer === gameState.currentQuestion.correct_answer;
    return {
        correct: isCorrect,
        correct_answer: gameState.currentQuestion.correct_answer
    };
}

/**
 * Load and display a new question
 */
async function loadQuestion() {
    gameState.isAnswered = false;
    hideFeedback();
    elements.nextBtn.classList.add('hidden');
    
    elements.questionText.textContent = 'Loading question...';
    
    const question = await fetchQuestion();
    gameState.currentQuestion = question;
    
    elements.questionText.textContent = question.question;
    renderStaff(question.notes);
    renderAnswerOptions(question.options);
}

/**
 * Start the game
 */
function startGame() {
    gameState.score = 0;
    gameState.questionsAnswered = 0;
    mockQuestionIndex = 0;
    updateScore();
    
    elements.startBtn.classList.add('hidden');
    loadQuestion();
}

/**
 * Initialize the application
 */
function init() {
    // Event listeners
    elements.startBtn.addEventListener('click', startGame);
    elements.nextBtn.addEventListener('click', loadQuestion);
    
    // Initial staff render (demo)
    renderStaff();
    
    // Show welcome message
    elements.questionText.textContent = 'Click "Start Game" to begin!';
}

// Initialize when DOM is ready
document.addEventListener('DOMContentLoaded', init);
