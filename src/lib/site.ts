// Site-wide configuration — single source of truth
export const SITE = {
  title: 'J. Michael Browning',
  shortTitle: 'JMB',
  domain: 'jmichaelbrowning.com',
  url: 'https://jmichaelbrowning.com',
  description:
    'J. Michael Browning operates at the intersection of strategy, systems, and execution. A working archive of mission-driven work in modernization, communications, and digital infrastructure.',
  author: 'J. Michael Browning',
  email: 'hello@jmichaelbrowning.com',
  location: 'Washington, D.C.',
  social: {
    linkedin: 'https://linkedin.com/in/jmichaelbrowning',
    github: 'https://github.com/jmichaelbrowning',
    substack: 'https://jmichaelbrowning.substack.com'
  }
} as const;

export const NAV: { num: string; label: string; href: string }[] = [
  { num: '01', label: 'Home',    href: '/' },
  { num: '02', label: 'About',   href: '/about' },
  { num: '03', label: 'Work',    href: '/work' },
  { num: '04', label: 'Writing', href: '/writing' },
  { num: '05', label: 'Notes',   href: '/notes' },
  { num: '06', label: 'Now',     href: '/now' },
  { num: '07', label: 'Contact', href: '/contact' }
];

export const SIDE_NAV = [
  { label: 'Speaking & Media', href: '/speaking' },
  { label: 'Uses / Stack',     href: '/uses' },
  { label: 'Archive',          href: '/writing' }
];
