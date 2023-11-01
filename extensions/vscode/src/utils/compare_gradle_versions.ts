export function compareGradleVersions(versionA: string, versionB: string): number {
    const partsA: number[] = versionA.split('.').map(Number);
    const partsB: number[] = versionB.split('.').map(Number);
  
    for (let i = 0; i < Math.max(partsA.length, partsB.length); i++) {
      const a: number = partsA[i] || 0;
      const b: number = partsB[i] || 0;
  
      if (a < b) {
        return -1;
      } else if (a > b) {
        return 1;
      }
    }
  
    return 0;
  }
  