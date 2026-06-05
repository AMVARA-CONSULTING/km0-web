const CLOUD_USERS_URL = 'https://cloud.km0digital.com/graph/v1.0/users';

export type CloudUserCountResult =
  | { ok: true; count: number }
  | { ok: false; reason: 'missing_credentials' | 'fetch_failed' | 'invalid_response' };

function readCredential(name: 'CLOUD_ADMIN_USER' | 'CLOUD_APP_TOKEN'): string | undefined {
  const fromMeta = import.meta.env[name];
  if (typeof fromMeta === 'string' && fromMeta.length > 0) return fromMeta;
  const fromProcess = process.env[name];
  if (typeof fromProcess === 'string' && fromProcess.length > 0) return fromProcess;
  return undefined;
}

/** Fetches OpenCloud user count at build time (Graph API). Credentials never leave the build step. */
export async function fetchCloudUserCount(): Promise<CloudUserCountResult> {
  const user = readCredential('CLOUD_ADMIN_USER');
  const token = readCredential('CLOUD_APP_TOKEN');
  if (!user || !token) {
    return { ok: false, reason: 'missing_credentials' };
  }

  try {
    const credentials = Buffer.from(`${user}:${token}`).toString('base64');
    const response = await fetch(CLOUD_USERS_URL, {
      headers: { Authorization: `Basic ${credentials}` },
    });
    if (!response.ok) {
      return { ok: false, reason: 'fetch_failed' };
    }
    const data = (await response.json()) as { value?: unknown };
    if (!Array.isArray(data.value)) {
      return { ok: false, reason: 'invalid_response' };
    }
    return { ok: true, count: data.value.length };
  } catch {
    return { ok: false, reason: 'fetch_failed' };
  }
}
