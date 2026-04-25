// functions/api/contact.ts
// Cloudflare Pages Function — handles POST /api/contact
// Deploy: committed to repo, Cloudflare builds it automatically.
// Wire to an email provider (Resend, SendGrid, Mailgun) by setting
// the RESEND_API_KEY environment variable in your Cloudflare Pages settings.

interface Env {
  RESEND_API_KEY?: string;
  CONTACT_TO_EMAIL?: string;
}

export const onRequestPost: PagesFunction<Env> = async ({ request, env }) => {
  const headers = { 'Content-Type': 'application/json' };

  try {
    const body = await request.formData();
    const name  = String(body.get('name')  ?? '').trim();
    const email = String(body.get('email') ?? '').trim();
    const org   = String(body.get('org')   ?? '').trim();
    const brief = String(body.get('brief') ?? '').trim();

    if (!name || !email || !brief) {
      return new Response(
        JSON.stringify({ ok: false, error: 'Name, email, and brief are required.' }),
        { status: 400, headers }
      );
    }

    const toEmail = env.CONTACT_TO_EMAIL ?? 'hello@jmichaelbrowning.com';

    // ── Resend integration ──────────────────────────────────────────────
    // Set RESEND_API_KEY in Cloudflare Pages → Settings → Environment variables
    if (env.RESEND_API_KEY) {
      const res = await fetch('https://api.resend.com/emails', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${env.RESEND_API_KEY}`,
        },
        body: JSON.stringify({
          from: 'site@jmichaelbrowning.com',
          to:   [toEmail],
          reply_to: email,
          subject: `New brief from ${name}${org ? ` · ${org}` : ''}`,
          text: `Name: ${name}\nEmail: ${email}\nOrganization: ${org}\n\n---\n\n${brief}`,
        }),
      });

      if (!res.ok) {
        const err = await res.text();
        console.error('Resend error:', err);
        return new Response(
          JSON.stringify({ ok: false, error: 'Failed to send. Try emailing directly.' }),
          { status: 502, headers }
        );
      }
    } else {
      // No email provider configured — log and return success anyway
      // (useful for initial testing; replace with real integration)
      console.log('[contact]', { name, email, org, brief });
    }

    // Redirect back with success flag
    return Response.redirect(
      new URL('/?sent=1', request.url).toString(),
      303
    );
  } catch (err) {
    console.error('[contact] unexpected error', err);
    return new Response(
      JSON.stringify({ ok: false, error: 'Unexpected error. Please email directly.' }),
      { status: 500, headers }
    );
  }
};
