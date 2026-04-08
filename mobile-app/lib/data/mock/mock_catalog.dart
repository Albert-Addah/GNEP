import 'dart:math';

import '../models/app_models.dart';

class MockCatalog {
  static const levels = ['100', '200', '300'];

  static final List<Programme> programmes = [
    Programme(
      id: 'nursing',
      name: 'Nursing',
      description: 'Core nursing science, patient care, and clinical practice.',
      courses: [
        Course(
          id: 'anatomy',
          name: 'Anatomy & Physiology',
          code: 'NUR 101',
          description: 'Human body systems and their function in nursing care.',
          topics: [
            Topic(
              id: 'cell-structure',
              title: 'Cell Structure and Function',
              summary:
                  'Build a solid foundation in organelles, transport, and tissue health.',
              videoDuration: '18 min',
              notesCount: 4,
              questionBank: [
                QuizQuestion(
                  id: 'csf-1',
                  prompt: 'Which organelle is known as the powerhouse of the cell?',
                  options: ['Nucleus', 'Mitochondrion', 'Golgi body', 'Ribosome'],
                  correctIndex: 1,
                  explanation:
                      'Mitochondria generate ATP, which powers most cell activities.',
                ),
                QuizQuestion(
                  id: 'csf-2',
                  prompt: 'Diffusion moves particles from:',
                  options: [
                    'Low to high concentration',
                    'High to low concentration',
                    'Outside to inside only',
                    'Inside to outside only',
                  ],
                  correctIndex: 1,
                  explanation:
                      'Diffusion is passive movement from an area of higher concentration to lower concentration.',
                ),
              ],
            ),
            Topic(
              id: 'cardio-system',
              title: 'Cardiovascular System',
              summary: 'Understand circulation, heart chambers, and blood flow.',
              videoDuration: '22 min',
              notesCount: 3,
              questionBank: [
                QuizQuestion(
                  id: 'cvs-1',
                  prompt: 'Which chamber pumps oxygenated blood to the body?',
                  options: [
                    'Right atrium',
                    'Right ventricle',
                    'Left atrium',
                    'Left ventricle',
                  ],
                  correctIndex: 3,
                  explanation:
                      'The left ventricle sends oxygenated blood into systemic circulation.',
                ),
                QuizQuestion(
                  id: 'cvs-2',
                  prompt: 'The pulse rate helps a nurse assess:',
                  options: [
                    'Bone density',
                    'Circulatory status',
                    'Visual acuity',
                    'Liver function',
                  ],
                  correctIndex: 1,
                  explanation:
                      'Pulse rate is a basic indicator of heart and circulatory function.',
                ),
              ],
            ),
          ],
        ),
        Course(
          id: 'fundamentals',
          name: 'Fundamentals of Nursing',
          code: 'NUR 103',
          description: 'Patient safety, ethics, communication, and bedside care.',
          topics: [
            Topic(
              id: 'infection-prevention',
              title: 'Infection Prevention',
              summary: 'Apply hand hygiene and sterile technique in daily care.',
              videoDuration: '16 min',
              notesCount: 5,
              questionBank: [
                QuizQuestion(
                  id: 'ip-1',
                  prompt: 'What is the most effective way to prevent hospital-acquired infection?',
                  options: [
                    'Bed rest',
                    'Hand hygiene',
                    'Double gloving always',
                    'Routine antibiotics',
                  ],
                  correctIndex: 1,
                  explanation:
                      'Hand hygiene is the most effective and consistent infection prevention practice.',
                ),
                QuizQuestion(
                  id: 'ip-2',
                  prompt: 'Sterile technique is most important during:',
                  options: [
                    'Taking a temperature',
                    'Making a bed',
                    'Invasive procedures',
                    'Routine exercise',
                  ],
                  correctIndex: 2,
                  explanation:
                      'Invasive procedures carry higher infection risk and require sterile technique.',
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    Programme(
      id: 'midwifery',
      name: 'Midwifery',
      description: 'Maternal health, newborn care, and reproductive health practice.',
      courses: [
        Course(
          id: 'maternal-health',
          name: 'Maternal Health',
          code: 'MID 201',
          description: 'Antenatal care, labour support, and postnatal monitoring.',
          topics: [
            Topic(
              id: 'antenatal-assessment',
              title: 'Antenatal Assessment',
              summary: 'Routine checks and warning signs during pregnancy.',
              videoDuration: '19 min',
              notesCount: 4,
              questionBank: [
                QuizQuestion(
                  id: 'aa-1',
                  prompt: 'Antenatal visits primarily help to:',
                  options: [
                    'Replace delivery planning',
                    'Monitor mother and fetus',
                    'Eliminate all labour pain',
                    'Delay fetal growth',
                  ],
                  correctIndex: 1,
                  explanation:
                      'Antenatal visits monitor maternal and fetal wellbeing and identify risk early.',
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    Programme(
      id: 'teacher-education',
      name: 'Teacher Education',
      description: 'Professional education studies and classroom practice.',
      courses: [
        Course(
          id: 'learning-theories',
          name: 'Learning Theories',
          code: 'TED 101',
          description: 'Foundations of student learning and classroom application.',
          topics: [
            Topic(
              id: 'constructivism',
              title: 'Constructivism',
              summary: 'How learners actively build understanding.',
              videoDuration: '14 min',
              notesCount: 2,
              questionBank: [
                QuizQuestion(
                  id: 'con-1',
                  prompt: 'Constructivism emphasizes that learners:',
                  options: [
                    'Memorize only',
                    'Build knowledge actively',
                    'Avoid reflection',
                    'Work without context',
                  ],
                  correctIndex: 1,
                  explanation:
                      'Constructivism sees learning as active meaning-making, not passive reception.',
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ];

  static Programme programmeById(String id) {
    return programmes.firstWhere((programme) => programme.id == id);
  }

  static List<QuizQuestion> questionsForProfile(StudentProfile profile, QuizMode mode) {
    final programme = programmeById(profile.programmeId);
    final allQuestions = programme.courses
        .expand((course) => course.topics)
        .expand((topic) => topic.questionBank)
        .toList();

    final questions = switch (mode) {
      QuizMode.topic => programme.courses.first.topics.first.questionBank,
      QuizMode.course => programme.courses.first.topics.expand((topic) => topic.questionBank).toList(),
      QuizMode.level => allQuestions,
      QuizMode.mockExam => [...allQuestions, ...allQuestions],
    };

    final randomized = [...questions]..shuffle(Random());
    return randomized.take(min(randomized.length, 6)).toList();
  }
}
